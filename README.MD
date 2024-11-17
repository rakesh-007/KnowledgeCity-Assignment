# KnowledgeCity AWS Infrastructure

## Architecture Diagram

### **Front-End Applications**
- **Services Used**:  
  - React and Svelte SPAs are hosted on **Amazon S3** (Static Website Hosting) with **CloudFront** for fast, low-latency content delivery and caching across edge locations globally.
- **User Interaction**:  
  - Users access the front-end via **CloudFront**, which caches static assets (HTML, CSS, JS, etc.) for faster load times.

---

### **API**
- **Services Used**:  
  - **Amazon EKS**: Kubernetes cluster hosting the monolithic PHP application.  
  - **RDS MySQL**: Backend database for the PHP application.  
- **Networking**:  
  - Traffic is routed through an **Application Load Balancer (ALB)** connected to EKS, providing scalability and redundancy.

---

### **Reporting Microservice**
- **Services Used**:  
  - **Amazon EKS**: Separate namespace in the cluster hosting the microservice.  
  - **ClickHouse**: Highly scalable database for reporting.  
- **Data Flow**:  
  - Ingests and analyzes data; integrates with the API and other services as needed.

---

### **Media Server**
- **Services Used**:  
  - **EC2 Instances**: Managed Python-based media server for video encryption.  
  - **S3 Buckets**: Stores encrypted video content.  
- **Traffic Security**:  
  - Encrypted with **SSL/TLS (ACM)** to secure video delivery.

---

## High Availability and Geographical Redundancy

### **Multi-Region Deployment**
- Primary region in Saudi Arabia and failover in a secondary region.

### **Replication**
- **RDS Read Replicas**: Synchronous replication between regions.  
- **S3 Cross-Region Replication**: Automatic data synchronization.  
- **CloudFront**: Distributes cached content from both regions.

### **Failover Mechanisms**
- **Route 53** Health Checks with automated DNS failover between regions.

---

## Security
- Enforced encryption in transit using **TLS** for APIs and media traffic.  
- **IAM roles**, **Security Groups**, and **NACLs** provide access control.

---

## Achieving 99.99% Availability
- **Redundancy**:  
  - All critical services (API, databases, media server) are deployed with redundancy using Auto Scaling Groups, multi-zone availability, and multi-region backups.  
- **Failover**:  
  - Route 53 automatically directs traffic to the secondary region in case of failure in the primary region.  
- **Disaster Recovery**:  
  - **RDS** provides automated backups and snapshots, replicated across regions.  
  - **S3 Cross-Region Replication** ensures data availability.  
  - EKS applications are deployed with **Helm charts** supporting rolling updates and failover.

---

## Encryption Mechanisms
- **Video Traffic and API Interactions**:  
  - Encrypted using **SSL/TLS** via ACM-managed certificates.  
- **Data at Rest**:  
  - Encrypted with **KMS** for S3 and RDS.

---

## Fast Content Delivery
- **CloudFront** improves performance with edge caching and minimizes latency for global users.  
- Integrated with S3 for seamless delivery of static assets.

---

## Encapsulation of Databases
- **RDS Instances**:  
  - Created with **parameter groups** allowing isolation for client-specific configurations.  
- Supports provisioning additional isolated databases as needed via Terraform or AWS CLI.

---

## Disaster Recovery and Failover
- **S3 and RDS**: Implement cross-region replication.  
- **EKS Applications**: Use manifests that can be redeployed in the failover region with minimal downtime.  
- Backup strategies are implemented for **ClickHouse databases**.

---

## Cost Optimization
- **Reserved EC2 and RDS Instances**: Reduce costs significantly.  
- **EKS Auto Scaling**: Minimizes unused resources.  
- **CloudFront**: Reduces bandwidth costs by caching content closer to users.  
- **ClickHouse**: An open-source database, providing a cost-effective solution for analytics.
