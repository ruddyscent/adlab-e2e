# ADLab-e2e

This repository provides Docker containers for running end-to-end autonomous driving simulations. Each container is defined by a Dockerfile, and you can run multiple containers simultaneously using Docker Compose. The setup leverages Carla for simulation, ROS for robotics middleware, and Jupyter for interactive development and visualization.

## 1. Containers Overview

The repository includes three main containers, each serving a distinct purpose in the simulation pipeline:

- **Carla**: Runs the [Carla simulator](https://carla.org/), a leading open-source simulator for autonomous driving research.
- **Runner**: Hosts a [Jupyter Notebook](https://jupyter.org/) server configured with [PyTorch](https://pytorch.org/), [Scenario Runner](https://github.com/carla-simulator/scenario_runner), and [Leaderboard](https://leaderboard.carla.org/) modules to support development and evaluation of driving algorithms.
- **ROS**: Contains [ROS](https://www.ros.org/), a version of the Robot Operating System, including the ROS Bridge to facilitate communication between Carla and ROS nodes.

## 2. Setup Instructions

Follow these steps to set up and run the simulation environment:

### 2.1 Environment Configuration

Create a `.env` file in the root directory of your repository to configure environment variables required by Docker Compose:

```dotenv
# .env file
UID=1000 # User ID of the current user
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

`wget -O AdditionalMaps_0.9.15.tar https://tiny.carla.org/additional-maps-0-9-15-linux`

## 3. Running the Simulation

1. **Build Containers**: Use Docker Compose to build all containers by running:
   ```bash
   docker-compose build
   ```

2. **Start Containers**: Launch the containers using:
   ```bash
   docker-compose up
   ```

   This command will start the Carla simulator, Jupyter Notebook server, and ROS environment, connecting all components as configured.

3. **Access Jupyter Notebooks**: Open your web browser and go to `http://localhost:8888` (or the port specified in your `.env` file). Use the token specified in `JUPYTER_TOKEN` to log in.

## 4. Development and Experimentation

- **Carla Simulator**: The simulator is accessible on the port specified by `CARLA_RPC_PORT` and can be interacted with using Carla clients.
- **Jupyter Notebooks**: Use Jupyter Notebooks for running experiments, analyzing data, and visualizing simulation results. The setup includes PyTorch support for deep learning model development.
- **ROS Integration**: Leverage ROS nodes to create complex robotic systems and test autonomous driving algorithms in simulated environments.

## 5. Troubleshooting

- **GPU Configuration**: Ensure that your Docker setup is configured to use NVIDIA GPUs. You may need to install the NVIDIA Container Toolkit if not already set up.
- **Networking Issues**: If containers cannot communicate, check the network settings in your `compose.yml` and ensure that the correct ports are open and not blocked by firewalls.

## 6. Contributing

Contributions are welcome! Please open an issue or submit a pull request to contribute to this project.

## 7. License

This project is licensed under the MIT License. See the `LICENSE` file for more details.
