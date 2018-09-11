# Installation scripts for applications supported by the Cloudiator application catalogue

## Overview

Currently the Application Catalogue supports three types of applications: Generic, Distributed Databases and Big Data Frameworks.

The scripts for each application type follows its own structure as explained below. 

### Generic Applications

TODO

### Distributed Databases

- install
  - required by all components
  - installs binaray and dependecies
- init
  - required by all components
  - install binary and configure node
- seed
  - required by **SEED** components
  - configures tables
- data
  - required by **DATA** components
  - connects to **SEED** nodes

### Big Data Frameowork

TODO
