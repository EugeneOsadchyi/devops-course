# DevOps Course

## Task

Розгорнути програму в кластері k8s, кластер в свою чергу розгорнути в хмарі. Налаштувати CI/CD на базі Jenkins, підготувати інфраструктуру за допомогою terraform.


1) В якості програми беремо відомий нам проект на базі node.js https://github.com/benc-uk/nodejs-demoapp. На його основі збираємо Docker образ у якому має бути `nginx + node.js app`. Nginx повинен проксирувати запити, що прийшли на 80 порт на 3000 порт програми. Усі необхідні файли для збирання кладіть на github (посилання на нього додаєте до ДЗ).

2) За допомогою Jenkins організуєте забір образу з github, білд образу та розміщення образу в Docker registry (можна на Docker Hub).
    Окремо Jenkins повинен зробити деплой програми у підготовлений, у хмарі k8s кластер.
    Кількість подів у деплої має бути 4.
    Самих деплоїв має бути також 4.
    До кожного деплою необхідно створити сервіс.
    І на завершення встановити та налаштувати ingress. Правила для ingress повинні містити 4 різні імені, кожне з яких призводить до свого сервісу.

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

            ingress[Ingress NGINX] -- /service_1 --> service_1
            ingress[Ingress NGINX] -- /service_2 --> service_2
            ingress[Ingress NGINX] -- /service_3 --> service_3
            ingress[Ingress NGINX] -- /service_4 --> service_4

        end

        client([client]) --> ingress

        classDef plain fill:#ddd,stroke:#fff,stroke-width:4px,color:#000;
        classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff;
        classDef cluster fill:#fff,stroke:#bbb,stroke-width:2px,color:#326ce5;
        class ingress,service,pod1_1,pod1_2,pod1_3,pod1_4,pod2_1,pod2_2,pod2_3,pod2_4,pod3_1,pod3_2,pod3_3,pod3_4,pod4_1,pod4_2,pod4_3,pod4_4,service_1,service_2,service_3,service_4 k8s;
        class client plain;
        class cluster cluster;
    ```

    Всі установки та налаштування по максимуму необхідно автоматизувати за допомогою yaml файлів і Jenkins.
    Завдання для Jenkins потрібно зробити через jenkinsfile (його прикладаєте до ДЗ)

3) Майданчик для програми у хмарі має виглядати так:

    Мережа:
    - Створюєте окрему віртуальну мережу із двома підмережами, одна приватна одна публічна. Для приватної мережі організовує вихід в інтернет.
    - Налаштовуєте необхідні правила для трафіку та машрутизацію (якщо потрібно)
    - Можливо, потрібно використовувати балансувальник, а кластер k8s помістити в приватну мережу J

    Розгортаєте кластер k8s (дві ноди буде достатньо).

    У приватній мережі розгортаєте SQL інстанс, приєднуєте його до кластера k8s (для майбутнього використання).

Все, що потрібно для створення майданчика в хмарі, робите за допомогою тераформ, файлики прикладаєте до ДЗ.
