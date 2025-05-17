# App-CICD-prototype
Practicing end to end cycle for DevOps

**Project Diagram:**
![Project Diagram](images/diagram.png)

**Container image** of the flask app and gunicorn:
[Docker Hub](https://docker.io/jupitercommits/app-cicd-prototype)

No one can access the flask app directly (on port 5000) but need to access the WSGI server (Gunicorn) first

security group allows users to request the port of Nginx

This project focuses on each module and integrating them, but to deploy this to a production environment several enhancements are needed:

- Design the underlying architecture itself, for Jenkins, and for the containers to run on multiple hosts or on Kubernetes
- Use multiple replicas of containers to avoid single points of failure
- Attach a domain name, use machines in private subnets with NAT gateway for egress traffic instead of public ones



**What was automated:**

- Container for the app with Gunicorn
- Provisioning cloud infrastructure with Terraform
- Configuration and setup using Ansible
- Using Docker compose to run app image, Nginx, Prometheus, and Grafana


## Screenshots:

Requisting gunicorn before adding nginx:
![](images/demo_gunicorn.png)

Requisting nginx:
![](images/demo_nginx.png)

Redirection to HTTPS:

![](images/redirection.png)

Configure Jenkins with GitHub repository:
![](images/jenkins_repository.png)

Checking target health on Prometheus:
![](images/prometheus_target.png)

Query on Prometheus:
![](images/prometheus_query.png)

Dashboard on Grafana:
![](images/grafana_dashboard.png)


## Useful commands:

To generate a self signed certificate:
``` bash
openssl req -x509 -nodes -days 365 -newkey rsa:3072 -keyout ./reverse_proxy/self_signed/nginx.key -out ./reverse_proxy/self_signed/nginx.crt
```
