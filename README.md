# 🧮 Scientific Calculator - Complete DevOps Pipeline with Ansible

A feature-rich scientific calculator application built with Python, demonstrating professional DevOps practices including CI/CD, containerization, and automated deployment.

## 🌟 Features

### 📱 Interactive Interfaces
- **🌐 Web Interface**: Beautiful, responsive web GUI accessible via browser
- **💻 CLI Interactive Mode**: Traditional command-line interface with menu
- **⚡ Command Line Arguments**: Direct operation execution for automation

### 🔢 Mathematical Operations
- **√ Square Root**: Calculate square root of positive numbers
- **! Factorial**: Calculate factorial of non-negative integers
- **ln Natural Logarithm**: Calculate natural logarithm of positive numbers
- **^ Power**: Calculate x raised to the power of b

## 🚀 DevOps Pipeline

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   GitHub    │ => │   Jenkins   │ => │ Docker Hub  │ => │   Ansible   │
│ Source Code │    │   CI/CD     │    │  Registry   │    │ Deployment  │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

### ✅ Complete Pipeline Features
- **Version Control**: Git with GitHub repository
- **Automated Testing**: pytest with 6 comprehensive test cases
- **Continuous Integration**: Jenkins pipeline with automatic builds
- **Containerization**: Docker with multi-stage builds
- **Registry**: Automated push to Docker Hub
- **Configuration Management**: Ansible playbooks for deployment
- **Interactive Deployment**: Web interface + CLI support

## 🏗️ Project Structure

```
sci-calc/
├── 📄 calculator.py          # Core calculator functions
├── 🌐 web_calculator.py      # Flask web interface
├── 🧪 tests/
│   └── test_calculator.py    # Comprehensive unit tests
├── 🐳 Dockerfile            # Container definition
├── 🔧 Jenkinsfile           # CI/CD pipeline configuration
├── 📦 requirements.txt      # Python dependencies
├── ⚙️  pyproject.toml        # Project configuration
├── 📋 setup.cfg             # Build configuration
├── 🎨 templates/
│   └── index.html           # Beautiful web interface
├── 🤖 ansible/
│   ├── inventory.ini        # Deployment targets
│   ├── deploy.yml           # Ansible playbook
│   └── ansible.cfg          # Ansible configuration
└── 📖 README.md             # This file
```

## 🛠️ Technology Stack

- **Backend**: Python 3.11+ with Flask
- **Testing**: pytest with comprehensive coverage
- **Containerization**: Docker with multi-stage builds
- **CI/CD**: Jenkins with automated pipelines
- **Configuration Management**: Ansible
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Version Control**: Git with GitHub

## 🚀 Quick Start

### Prerequisites
- Docker installed (for Docker deployment)
- Python 3.8+ (for local development)

### Quick Start - Docker Hub (Recommended)
```bash
# Pull and run the pre-built image directly from Docker Hub
docker pull malluvkcr7/sci-calc:latest
docker run -p 8090:8080 malluvkcr7/sci-calc:latest

# The calculator will be available at: http://localhost:8080
```

### Development Setup

#### 1. Clone Repository
```bash
git clone https://github.com/malluvkcr7/calci_ma.git
cd calci_ma
```

#### 2. Run with Docker (Build from Source)
```bash
# Build the image locally
docker build -t sci-calc .

# Run web interface (recommended)
docker run -d -p 8080:8080 --name sci-calc-web sci-calc

# Access web interface
open http://localhost:8080
```

### 3. Local Development
```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # Linux/Mac
# or
venv\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt

# Run tests
pytest tests/ -v

# Run web interface
python web_calculator.py

# Run CLI interactive mode
python calculator.py
```

## 💻 Usage Examples

### Web Interface
1. Open `http://localhost:8090` in your browser
2. Enter values in the input fields
3. Click calculate buttons or press Enter
4. View results with beautiful animations

### CLI Interactive Mode
```bash
# Interactive menu
docker exec -it sci-calc-web python calculator.py

# Direct commands
docker exec sci-calc-web python calculator.py sqrt 25
docker exec sci-calc-web python calculator.py factorial 5
docker exec sci-calc-web python calculator.py ln 2.718
docker exec sci-calc-web python calculator.py power 2 8
```

### Expected Results
```bash
sqrt(25) = 5.0
factorial(5) = 120
ln(2.718) ≈ 0.999
power(2, 8) = 256.0
```

## 🧪 Testing

The project includes comprehensive unit tests covering:
- ✅ Basic operations (sqrt, factorial, ln, power)
- ✅ Edge cases and error conditions
- ✅ Input validation
- ✅ Domain-specific constraints

```bash
# Run all tests
pytest tests/ -v

# Run with coverage
pytest tests/ --cov=calculator --cov-report=html
```

## 🔄 CI/CD Pipeline

### Jenkins Pipeline Stages

#### Stage 1: Checkout
- Clones the latest code from GitHub repository
- Initializes the workspace for build process
- Ensures clean state for each build

#### Stage 2: Setup Python
- Creates isolated Python virtual environment
- Installs all project dependencies from requirements.txt
- Prepares Python environment for testing and building

#### Stage 3: Test
- Executes comprehensive test suite using pytest
- Runs all unit tests with coverage reporting
- Validates code quality and functionality before deployment
- Fails the pipeline if any tests fail

#### Stage 4: Build Docker Image
- Creates optimized Docker image using multi-stage builds
- Tags image with both build number and 'latest' tags
- Implements efficient layer caching for faster builds
- Includes all application dependencies and configurations

#### Stage 5: Registry Push & Deployment
- Authenticates with Docker Hub using stored credentials
- Pushes both versioned and latest tags to public registry
- Enables immediate public access to updated application
- Maintains deployment history through tagged versions

#### Stage 6: Ansible Deployment & Verification
- **Automated Infrastructure Management**: Uses Ansible playbooks for consistent deployments
- **Dynamic Configuration**: Updates inventory with current build number for versioned deployments
- **Container Lifecycle Management**: Stops existing containers, pulls latest images, and deploys new versions
- **Health Verification**: Performs automated health checks and functional testing post-deployment
- **Fallback Mechanism**: Includes robust error handling with direct Docker deployment fallback
- **Production Readiness**: Configures port mappings (8090:8080) and environment variables
- **Deployment Validation**: Tests API endpoints and web interface accessibility
- **Rollback Capability**: Maintains previous image versions for quick rollback if needed

### Automated Triggers
- ✅ Automatic builds on GitHub push
- ✅ Test execution on every commit
- ✅ Docker image versioning with build numbers
- ✅ Deployment verification and health checks

## 🚀 Deployment & Public Access

### Docker Hub - Public Access
The calculator is available as a public Docker image on Docker Hub:

**Repository**: `malluvkcr7/sci-calc:latest`

**For End Users** (No setup required):
```bash
# Anyone can pull and run directly
docker pull malluvkcr7/sci-calc:latest
docker run -p 8080:8080 malluvkcr7/sci-calc:latest

# Calculator available at: http://localhost:8080
```

**What users get**:
- ✅ **No installation needed** - Just Docker required
- ✅ **Pre-built image** - No compilation or build process
- ✅ **Web interface** - Beautiful, responsive calculator UI
- ✅ **All functions** - Scientific operations ready to use
- ✅ **Cross-platform** - Works on Windows, Mac, Linux

### Ansible Deployment (For Developers)
```bash
# Navigate to ansible directory
cd ansible/

# Run Ansible deployment playbook
ansible-playbook -i inventory.ini deploy.yml

# Or with specific image version
ansible-playbook -i inventory.ini deploy.yml -e "docker_image=malluvkcr7/sci-calc:latest"
```

### Manual Docker Deployment
```bash
# Pull from Docker Hub (same as end-user command)
docker pull malluvkcr7/sci-calc:latest

# Run container
docker run -d -p 8090:8080 --name sci-calc-prod malluvkcr7/sci-calc:latest

# Verify deployment
curl -X POST -H "Content-Type: application/json" \
  -d '{"operation":"sqrt","x":"16"}' \
  http://localhost:8090/calculate
```

## 📊 Monitoring & Management

### Container Management
```bash
# View running containers
docker ps | grep sci-calc

# View logs
docker logs sci-calc-web

# Execute commands
docker exec -it sci-calc-web /bin/bash

# Stop and remove
docker stop sci-calc-web && docker rm sci-calc-web
```

### Health Checks
```bash
# Test web interface
curl http://localhost:8090

# Test calculator API
curl -X POST -H "Content-Type: application/json" \
  -d '{"operation":"factorial","x":"5"}' \
  http://localhost:8090/calculate
```

## 🛡️ Error Handling

The application includes robust error handling:
- ✅ Domain validation (negative square roots, non-positive logarithms)
- ✅ Type checking (factorial requires integers)
- ✅ Input sanitization
- ✅ Graceful error messages
- ✅ Logging and monitoring

## 🎨 Web Interface Features

- **Responsive Design**: Works on desktop, tablet, and mobile
- **Modern UI**: Gradient backgrounds and smooth animations
- **Real-time Validation**: Immediate feedback on inputs
- **Keyboard Support**: Enter key triggers calculations
- **Error Display**: Clear error messages with styling
- **Professional Styling**: CSS3 with backdrop filters and shadows

## 🔧 Configuration

### Environment Variables
```bash
# Flask configuration
FLASK_ENV=production
FLASK_DEBUG=false

# Docker configuration  
DOCKER_REGISTRY=malluvkcr7
IMAGE_TAG=latest
```

### Ansible Variables
```yaml
# ansible/inventory.ini
docker_image: malluvkcr7/sci-calc:latest
container_name: sci-calc-app
container_port: 8080
host_port: 8090
```

## 📈 Performance

- **Build Time**: ~30 seconds (optimized Docker layers)  
- **Test Execution**: <2 seconds (6 comprehensive tests)
- **Container Size**: ~148MB (Python slim base)
- **Response Time**: <100ms (local calculations)
- **Memory Usage**: ~50MB (Flask + Python runtime)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass (`pytest tests/ -v`)
6. Commit changes (`git commit -m 'Add amazing feature'`)
7. Push to branch (`git push origin feature/amazing-feature`)
8. Create a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**malluvkcr7**
- GitHub: [@malluvkcr7](https://github.com/malluvkcr7)
- Docker Hub: [malluvkcr7](https://hub.docker.com/u/malluvkcr7)

## 🙏 Acknowledgments

- Built as part of Software Production Engineering (SPE) coursework
- Demonstrates professional DevOps practices and CI/CD pipelines
- Showcases modern web development with Python and Flask
- Implements comprehensive testing and deployment automation

## 📞 Support

For support, please:
1. Check the [Issues](https://github.com/malluvkcr7/calci_ma/issues) page
2. Create a new issue with detailed description
3. Include steps to reproduce and expected behavior

---

⭐ **Star this repository if you found it helpful!** ⭐

*Built with ❤️ and modern DevOps practices*# Pipeline test - Mon 06 Oct 2025 04:34:01 PM IST
