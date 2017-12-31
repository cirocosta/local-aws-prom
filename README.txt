    LOCAL-AWS-PROM

        Simulate AWS EC2 Prometheus monitoring locally.


    DEPENDENCIES
        
        Vagrant:    to create a set of Ubuntu Zesty (17.04) VMs;
        Docker:     to run prometheus (not all that necessary though -
                    can be replaced by prometheus binary).

    USAGE

        # create the VMs - spins 2 virtualbox nodes as described
        # by `./vagrant/Vagrantfile`.
        make run-vms

        # runs `prometheus` with a custom Docker image that provides
        # environemnt variable replacement to the configuration file
        make run-prometheus

    MORE

        Read more at https://ops.tips/blog/simulating-aws-tags-in-local-prometheus

