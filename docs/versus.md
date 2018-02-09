# Mgmt vs ...
Mgmt is standing on the shoulders of giants. There are many good tools in the industry that have proven their worth. This document tries not to disrespect these tools by saying why they are wrong or saying Mgmt is the solution. Merely it will give the information needed to make an informed decision in choosing the tool to use for the job at hand.

## Puppet
Both Puppet and Mgmt uses a declarative language/DSL and graph theory to build a chain of actions to bring a system to a desired state. Unlike Puppet Mgmt executes this chain in parallel as much as possible. Mgmt's reactive nature also means changes are applied as soon as they can when a discrepancy is detected unlike Puppet which has to wait for the next scheduled run.

Puppet uses a master/slave architecture possibly allowing single points of failure. Mgmt leaverages Etcd to automatically build and manage a cluster.

Although with custom scripting it is possible to run Puppet masterless it is quiet a hassle. Mgmt's runtime consists of a single binary that acts as both a daemon and (remote) client. A single node or entire cluster can be setup using a single SSH connection from a workstation.

Puppet has existed for a long long time. Meaning it is battle tested and proven. It has a large community that supports modules for almost every application out there. Puppet has enterprise support and offers a comprehencive suite as a product.

For managing information about complex environments and configurations Puppet uses Hiera (or other ENC's). This allows to structure configuration in highly customizable ways. Mgmt currently does not support such patterns.

Mgmt has integrations which allow to migrate existing Puppet configuration to Mgmt and use Puppet resources which are not (yet) available in Mgmt.

## Ansible
Ansible has gained a lot of adoption in the past years. It is easy to learn and has an extensive community supporting modules for various applications. It does not rely on master/slave infrastructure but applies the configuration from host (eg: workstation) via SSH.

The configuration language used by Ansible are imperative YAML/Jinja files organized in playbooks and roles. Lack of primary support for language features mean complex configurations create a high cognetive load and can be hard to debug, understand and reason about. Mgmt's declerative language tries to make sure you don't have to worry about the how but only about the what.

Ansible allows parallel execution across nodes but will execute its tasks in sequence on each host, every task checks if it needs to run everytime the configuration is applied. This makes large configuration applies slow. Mgmt executes in parallel on hosts and across a cluster. Its reactive nature ensures tasks are only executed when the underlying resource changes to an invalid state. Reducing the amount of work done and converging as quick as possible.

The inventory system in Ansible allows to quickly apply single tasks across multiple hosts simply from the command line. Mgmt allows similar simple invocation from the command line but as of yet has no easy way to execute against selected hosts or groups.

## Terraform
The primary focus of Terraform is infrastructure. It has an extensive collection of community supported resources for major cloud providers and systems.

Terraform keeps a state file for all modifications it made. It can compare the desired configuration to the recorded state and and state to the real configuration. This allows terraform to keep track of created resources and undo changes.

Configurations are applied from a workstation or CI system on demand.

## Salt

## Chef
