# Kubernetes Job Resource

## Installing

```
resource_types:
- name: kubernetes
  type: docker-image
  source:
    repository: jcderr/concourse-kubernetes-resource
resources:
- name: kubernetes
  type: kubernetes
  source:
    cluster_url: https://hostname:port
    namespace: default
    cluster_ca: _base64 encoded CA pem_
    auth_method: certs
    admin_key: _base64 encoded key pem_
    admin_cert: _base64 encoded certificate_
    resource_type: job
    resource_name: some_pod_name
```

## Source Configuration

* `cluster_url`: *Required.* URL to Kubernetes Master API service
* `namespace`: *Required.* Kubernetes namespace.
* `cluster_ca`: *Optional.* Base64 encoded PEM. Required if `cluster_url` is
  https.
* `auth_method`: *Optional.* Either `password` or `certs`.
* `username`: *Required if `auth_method` = `password`.* Admin username.
* `password`: *Required if `auth_method` = `password`.* Admin password.
* `admin_key`: *Required if `auth_method` = `certs`.* Base64 encoded PEM.
* `admin_cert`: *Required if `auth_method` = `certs`.* Base64 encoded PEM.
* `resource_type`: *Required.* Resource type to operate upon (valid values:
  `job` and a special one [`phoenix-job`](#phoenix-job)).
* `resource_name`: *Required.* Resource name to operate upon.

#### `out`: Begins Kubernetes Deploy Process

Applies a kubectl action.

#### Parameters
* `image_name`: *Required.* Path to file containing docker image name.
* `image_tag`: *Required.* Path to file container docker image tag.

### phoenix-job

This has been added out of a need for updating a Job (using the current name) with a new image. We use [cronetes](https://github.com/wercker/cronetes) to schedule jobs, this 
requires the job to have the same name. This resource type will be removed in favour of [cron-jobs](https://kubernetes.io/docs/user-guide/cron-jobs/) when it becomes non alpha. 
So consider this a alpha feature subject to change.

## Example

### Out
```
---
resources:
- name: k8s
  type: kubernetes
  source:
    cluster_url: https://kube-master.domain.example
    namespace: alpha
    resource_type: job
    resource_name: myjob
    container_name: mycontainer
    cluster_ca: _base64 encoded CA pem_
    auth_method: certs
    admin_key: _base64 encoded key pem_
    admin_cert: _base64 encoded certificate pem_
```

```
---
- put: k8s
  params:
    image_name: docker/repository
    image_tag: docker/tag
```
