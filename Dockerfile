# Docker image to use with Vagrant
# Aims to be as similar to normal Vagrant usage as possible
# Adds Puppet, SSH daemon, Systemd
# Adapted from https://github.com/BashtonLtd/docker-vagrant-images/blob/master/ubuntu1404/Dockerfile

FROM ubuntu:18.04
ENV container docker
RUN apt-get update -y && apt-get dist-upgrade -y

# Install system dependencies, you may not need all of these
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -y --no-install-recommends ssh sudo libffi-dev systemd openssh-client gnupg gnupg2 gnupg1 ufw rsync curl vim gpg-agent puppet wget

# Add vagrant user and key for SSH
RUN useradd --create-home -s /bin/bash vagrant --user-group
RUN usermod --append --groups sudo vagrant
RUN echo -n 'vagrant:vagrant' | chpasswd
RUN echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vagrant
RUN chmod 440 /etc/sudoers.d/vagrant
RUN mkdir -p /home/vagrant/.ssh
RUN chmod 700 -R /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgm1ZP8LqXF/6UERH9ZudhF4RcceTcWk5AztQwEv9FQ5kiqmFGRju05RiFNBpSxx6xy4qQBrLnO1o0PReeUKeR4/9y5Na9hCBQPx/c5fue+EUYxwJyo7AA16rc6es0vIm7axcegzFNMX1Ax/cWr6UNxjZcuQf0LPypMRuhzjVWGhulQeZPovv0HMU/4sOkSLtp4z3Xme93a4Clu9mpWNNnzPOWRkSQ+QhyvfUEHlGB6nIiBsydZRnRjp3/h8Zt/qZHuiSPAtly9W3yJrmbBzwbNiw3hVYyC+CuYzRLPQptxBlDPo2JDemOSvvSvQpy55ptT+qgg1TvnqdokO6tMGKl" > /home/vagrant/.ssh/authorized_keys
RUN chmod 640 /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant:vagrant /home/vagrant/.ssh
RUN sed -i -e 's/Defaults.*requiretty/#&/' /etc/sudoers
RUN sed -i -e 's/\(UsePAM \)yes/\1 no/' /etc/ssh/sshd_config

# Start SSH
RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd
EXPOSE 22
RUN /usr/sbin/sshd
# RUN ufw disable

# Start Systemd (systemctl)
CMD ["/lib/systemd/systemd"]
