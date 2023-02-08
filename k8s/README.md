# Configuring Kuberenetes cluster

### Install Ingress-Nginx
```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml
```

### Architecture diagram

```mermaid
---
title: Kubernetes Architecture diagram
---
flowchart LR
    subgraph cluster
        subgraph deployment_1[Deployment 1]
            pod1_1[Pod]
            pod1_2[Pod]
            pod1_3[Pod]
            pod1_4[Pod]
        end

        subgraph deployment_2[Deployment 2]
            pod2_1[Pod]
            pod2_2[Pod]
            pod2_3[Pod]
            pod2_4[Pod]
        end

        subgraph deployment_3[Deployment 3]
            pod3_1[Pod]
            pod3_2[Pod]
            pod3_3[Pod]
            pod3_4[Pod]
        end

        subgraph deployment_4[Deployment 4]
            pod4_1[Pod]
            pod4_2[Pod]
            pod4_3[Pod]
            pod4_4[Pod]
        end

        service_1[Service 1] --> deployment_1
        service_2[Service 2] --> deployment_2
        service_3[Service 3] --> deployment_3
        service_4[Service 4] --> deployment_4

        ingress[Ingress NGINX] -- app1.localhost --> service_1
        ingress[Ingress NGINX] -- app2.localhost --> service_2
        ingress[Ingress NGINX] -- app3.localhost --> service_3
        ingress[Ingress NGINX] -- app4.localhost --> service_4

    end

    client([client]) --> ingress

    classDef plain fill:#ddd,stroke:#fff,stroke-width:4px,color:#000;
    classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff;
    classDef cluster fill:#fff,stroke:#bbb,stroke-width:2px,color:#326ce5;
    class ingress,service,pod1_1,pod1_2,pod1_3,pod1_4,pod2_1,pod2_2,pod2_3,pod2_4,pod3_1,pod3_2,pod3_3,pod3_4,pod4_1,pod4_2,pod4_3,pod4_4,service_1,service_2,service_3,service_4 k8s;
    class client plain;
    class cluster cluster;
```
