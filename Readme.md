# Creación de AWS EKS Cluster y despliegue de aplicación

En este repositorio encontratas el código necesario para crear un EKS Cluster desde 0 utilizando terraform. También encontrarás los hacks y las instrucciones paso a paso para que puedas crear tu primer cluster y desplegar una aplicación accesible desde internet.

## Prerrequisitos

- Instalar AWS CLI y autenticarte en la linea de comando con tu cuenta de AWS.
  - [Instalar AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  - [Autenticarte con AWS CLI](https://docs.aws.amazon.com/es_es/cli/latest/userguide/cli-configure-quickstart.html)
- [Instalar Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Instalar Kubectl](https://kubernetes.io/es/docs/tasks/tools/included/)

## AWS EKS Cluster

### Crear de EKS Cluster

El modulo de terraform [EKS Cluster](terraform-aws/aws-eks-modules/eks-cluster) crea todos los componentes de networking requeridos para luego crear un EKS Cluster.

```sh
# Debes ubicarte en la carpeta "terraform-aws" para ejecutar este comando.
$ terraform apply --target module.eks-cluster
# Este modulo creará 17 recursos
```

### Actualizar el contexto de K8s

Actualizar el contexto de Kubernetes para conectar y autenticar kubectl con el cluster creado.

```sh
$ aws eks update-kubeconfig --name eks-cluster-cloud --region us-east-1
# Modificar el nombre y la region si estas utilizando diferentes valores.
```

### Crear Fargate profiles

El EKS Cluster utilizara perfiles de forgate para evitar la gestion de nodos, los perfiles de fargate se relacionan con los K8s namespaces para contener los recursos que se crearán.

```sh
# Debes ubicarte en la carpeta "terraform-aws" para ejecutar este comando.
$ terraform apply --target module.eks-fargate
# Este modulo creará 5 recursos.
```

### Crear K8s namespace

El primer recurso de K8s a crear es un namespace. En el paso anterior se creo un Fargate profile con el nombre development, por lo que, el namespace se llamara igual, si decides utilizar otro nombre para el Fargete profile deberás cambiar el nombre del namespace en el manifesto [namespace.yml](k8s-manifests/0-namespace.yml)

```sh
# Debes ubicarte en la carpeta "k8s-manifests" para ejecutar este comando o enviar la ruta completa del manifesto.
$ kubectl apply -f 0-namespace.yml
# kubectl es el comando que se utiliza para gestionar todos los recursos en el cluster.
```

### Crear Loadbalancer Controller

Para exponer las aplicaciones fuera del Cluster EKS utiliza los recursos de networking de AWS, principalmente los Loadbalancers, para que la implementación funcione es necesario instalar un controller en el EKS Cluster.

```sh
# Debes ubicarte en la carpeta "terraform-aws" para ejecutar este comando.
$ terraform apply --target module.loadbalancer-controller
# Este modulo creará 5 recurso.
```

### Desplegar applicación

La aplicación a desplegar cuenta con los siguientes componentes:

- Base de datos
- Backend
- Frontend
Cada componente de desplegara por separada y en orden de dependencia.

```sh
# Debes ubicarte en la carpeta "k8s-manifests" para ejecutar este comando o enviar la ruta completa del manifesto.
# Desplegar Base de Datos
$ kubectl apply -f 1-mongodb.yml
# Desplegar Backend
$ kubectl apply -f 2-backend.yml
# Desplegar Frontend
$ kubectl apply -f 3-frontend.yml
```

## Eliminar todos los recursos

Cuando termines tus pruebas es importante que destruyas todos los recursos para no incurrir en ningun gasto.

- Elimina todos los K8s services

```sh
# Obtener el nombre de los servicios
$ kubectl get services -n development
# Eliminar todos los servicios
$ kubectl delete service SERVICE_NAME -n development
```

- Elimnar todos los recuros de AWS

```sh
# Eliminar el loadbalancer controller 
$ terraform destroy --target module.loadbalancer-controller
# Eliminar los Fargate profiles
$ terraform-aws % terraform destroy --target module.eks-fargate
# Eliminar el EKS Cluster y todos los recursos de Red
terraform-aws % terraform destroy --target module.eks-cluster
```
