#!/usr/bin/perl
use warnings;
use strict;
use Fatal qw(open);
our $VERSION = '1.0.0';
my $stack_name = shift;

sub _process_stack_entry {
    my ($task_id, $task_image) = @_;
    open my $container_fn, q{-|},
        sprintf q#docker ps --filter "label=com.docker.swarm.task.id=%s" --no-trunc --format '{{.Image}} {{.ID}}'#, $task_id;
    $_ = <$container_fn>;
    (my ($image, $container_id) = m/^(\S+?)\s(\S+?)$/xms) || die "unable to parse '$_'\n";
    $container_fn->close();

    if ($image && $image ne $task_image) {
        open my $container_inspect_fn, q{-|},
            sprintf q#docker inspect --format '{{ index .Config.Labels "com.docker.swarm.service.name" }}' %s# , $container_id;
        my $service_name = <$container_inspect_fn>;
        chomp $service_name;
        $container_inspect_fn->close();
        open my $update_fn, q{-|},
            sprintf 'docker service update -d --no-resolve-image --force --image %s %s', $task_image, $service_name;
        my $updated_service_name = <$update_fn>;
        chomp $updated_service_name;
        $update_fn->close();
        if ($service_name ne $updated_service_name) {
            die "$service_name did not match $updated_service_name\n";
        }
        my $printed = (print "$updated_service_name\n");
        if (!$printed) {
            die "Unable to write to stdout\n";
        }
    }
    return 1;
}
open my $tasks_fn, q{-|},
    sprintf q#docker stack ps --format "{{.ID}} {{.Image}}" --filter "desired-state=running" --no-trunc %s#, $stack_name;
while (<$tasks_fn>) {
    (my ($task_id, $task_image) = m/^(\S+?)\s(\S+)$/xms) || die "unable to parse '$_'\n";
    _process_stack_entry($task_id, $task_image);
}
$tasks_fn->close();