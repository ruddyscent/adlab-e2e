# ADLab-e2e

This repository provides Docker- and Podman-compatible containers for running end-to-end autonomous driving simulations. The setup leverages Carla for simulation, ROS for robotics middleware, and Jupyter for interactive development and visualization.

## 1. Containers Overview

The repository includes three main containers, each serving a distinct purpose in the simulation pipeline:

- **Carla**: Runs the [Carla simulator](https://carla.org/), a leading open-source simulator for autonomous driving research.
- **Runner**: Hosts a [Jupyter Notebook](https://jupyter.org/) server configured with [PyTorch](https://pytorch.org/), [Scenario Runner](https://github.com/carla-simulator/scenario_runner), and [Leaderboard](https://leaderboard.carla.org/) modules to support development and evaluation of driving algorithms.
- **ROS**: Contains [ROS](https://www.ros.org/), a version of the Robot Operating System, including the ROS Bridge to facilitate communication between Carla and ROS nodes.

## 2. Setup Instructions

Follow these steps to set up and run the simulation environment:

### 2.1 Environment Configuration

Create a `.env` file in the repository root to configure Compose:

```dotenv
# .env file
UID=1000 # User ID of the current user (`id -u`)
CARLA_GPU_DEVICES=0 # GPU devices assigned to the Carla container
CARLA_RPC_PORT=2000 # Port number for Carla clients to connect (default: 2000)

JUPYTER_GPU_DEVICES=0 # GPU device assigned to the Jupyter container
JUPYTER_PORT=8888     # Port number for the Jupyter server (default: 8888)
JUPYTER_TOKEN=letmein # Authentication token for the Jupyter server
```

### 2.2 Carla Version

To set the version of Carla, modify the `CARLA_VER` variables in both the `compose.yml`. Ensure that the `CARLA_VER` value is consistent across containers. The default version is `0.9.15`.

```dockerfile
# Example: compose.yml
args:
   - CARLA_VER=0.9.15
```

### 2.3 Additional Carla Maps

To enhance your simulation environment with additional maps, download the desired map files from [Carla's releases](https://github.com/carla-simulator/carla/releases) page. Place these files in the root directory of your repository.

## 3. Running the Simulation

### 3.1 Docker

1. **Build Containers**:
   ```bash
   docker compose build
   ```

2. **Start Containers**: Launch the containers using:
   ```bash
   docker compose up
   ```

   This command will start the Carla simulator, Jupyter Notebook server, and ROS environment, connecting all components as configured.

3. **Access Jupyter Notebooks**: Open your web browser and go to `http://localhost:8888` (or the port specified in your `.env` file). Use the token specified in `JUPYTER_TOKEN` to log in.

### 3.2 Podman

Podman uses its CDI interface for NVIDIA GPU access, so include the Podman override file:

```bash
podman compose -f compose.yml -f compose.podman.yml build
podman compose -f compose.yml -f compose.podman.yml up
```

The NVIDIA Container Toolkit must provide the requested devices as CDI names. Verify them before starting the stack:

```bash
nvidia-ctk cdi list
```

If your distribution does not install a Compose provider for `podman compose`, install `podman-compose` and use the same `-f` arguments with that command.

## 4. Development and Experimentation

- **Carla Simulator**: The simulator is accessible on the port specified by `CARLA_RPC_PORT` and can be interacted with using Carla clients.
- **Jupyter Notebooks**: Use Jupyter Notebooks for running experiments, analyzing data, and visualizing simulation results. The setup includes PyTorch support for deep learning model development.
- **ROS Integration**: Leverage ROS nodes to create complex robotic systems and test autonomous driving algorithms in simulated environments.

## 5. Troubleshooting

- **GPU Configuration**: Ensure that the NVIDIA Container Toolkit is installed. Docker uses the device reservations in `compose.yml`; Podman uses the CDI devices in `compose.podman.yml`.
- **Stale Podman CDI configuration**: If Podman reports a missing NVIDIA library after a driver update, regenerate the CDI specification with `sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml`, then retry the stack. Podman 4.9 cannot parse CDI 0.7 specifications produced by recent NVIDIA Container Toolkit releases; upgrade Podman or convert the generated specification to CDI 0.6 and remove its `additionalGids` entries.
- **X11 Authentication**: The Compose configuration mounts `${HOME}/.Xauthority`. If your desktop session uses a different authentication file, create or update `${HOME}/.Xauthority` before starting the containers.
- **Networking Issues**: If containers cannot communicate, check the network settings in your `compose.yml` and ensure that the correct ports are open and not blocked by firewalls.

## 6. Contributing

Contributions are welcome! Please open an issue or submit a pull request to contribute to this project.

## 7. License

The original configuration files and code in this repository are licensed under the MIT License. See [LICENSE](LICENSE) for details.

Third-party software, container images, and assets used or downloaded by this project remain subject to their respective licenses and terms.
