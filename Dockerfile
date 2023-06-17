FROM public.ecr.aws/docker/library/fedora:38

ARG USER=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG HOME=/home/$USER

RUN python3 -m ensurepip && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install ansible

# install base packages
RUN dnf update -y && dnf install --allowerasing -y \
    util-linux

# RUN dnf -y install dnf-plugins-core && \
#     dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
# RUN dnf install -y \
#     docker-ce \
#     docker-ce-cli \
#     containerd.io \
#     docker-buildx-plugin \
#     docker-compose-plugin

# setup user
RUN groupadd --gid $USER_GID $USER \
    && useradd --uid $USER_UID --gid $USER_GID $USER \
    && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER \
    && chown -R $USER_UID:$USER_GID $HOME

USER $USER
WORKDIR ${HOME}
COPY --chown=${USER_UID}:${USER_GID} pde $HOME/pde
RUN ansible-playbook -vvv pde/ansible/fedora-playbook.yml