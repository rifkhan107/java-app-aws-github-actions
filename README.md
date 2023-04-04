<h1 align="center" id="title">Deploying a Spring Boot Application to AWS EKS using Terraform Amazon ECR and GitHub Actions CI/CD</h1>

<p id="description">This repository demonstrates how to deploy a Spring Boot application to Amazon EKS (Elastic Kubernetes Service) using Terraform for infrastructure management Amazon ECR (Elastic Container Registry) for container image storage and GitHub Actions for CI/CD (Continuous Integration/Continuous Deployment) automation. The project aims to create a scalable efficient and manageable infrastructure for deploying containerized Spring Boot applications.</p>

<br>
<h2>Project Screenshots:</h2>

<div style="text-align: center;">
  <img src="https://miro.medium.com/v2/resize:fit:1400/format:webp/1*Iz33oPzTOoKnzvvQOd24rg.jpeg" alt="project-screenshot" width="969" height="716"/>
</div>


<br>

<h2>🛠️ Getting Started:</h2>
<br>

```
https://github.com/rifkhan107/java-app-aws-github-actions.git
```

```
cd java-app-aws-github-actions
```
<br>
Follow the steps described in the <a href="https://rifkhan107.medium.com/deploying-a-spring-boot-application-to-aws-eks-using-terraform-amazon-ecr-and-github-actions-9edd71c2c3ab">blog post</a> to set up and deploy your Spring Boot application to AWS EKS using Terraform, Amazon ECR, and GitHub Actions.

<br>

<h2>Repository Structure:</h2>
<ul>
  <li><code>src/</code>: Spring Boot application source code</li>
  <li><code>Dockerfile</code>: Docker configuration file for building the container image</li>
  <li><code>main.tf</code>: Terraform configuration file for provisioning AWS resources</li>
  <li><code>.github/workflows/ci-cd.yml</code>: GitHub Actions workflow configuration for CI/CD</li>
</ul>

