all::

init::
	terraform init

construct::
	terraform apply

destroy::
	terraform destroy

setup-kubernetes::
	if [ ! -d /etc/ansible ]; then echo "you must run 'make setup-ansible'"; exit 1; fi
	ansible-playbook playbook/containerd.yml playbook/k8s.yml
	ansible-playbook playbook/master.yml playbook/workers.yml

setup-ansible::
	install -d /etc/ansible
	install ansible_config/hosts.yml /etc/ansible/hosts
	install ansible_config/ansible.cfg /etc/ansible/ansible.cfg

show-nodes:
	ssh -F ssh_config kubernetes kubectl get nodes

show-pods:
	ssh -F ssh_config kubernetes kubectl get pods

run-helloworld:
	ssh -F ssh_config kubernetes kubectl run hello-world --image=hello-world --restart=Never
	sleep 5
	make show-pods
	ssh -F ssh_config kubernetes kubectl logs pod/hello-world

clean::
	make destroy
	rm -rfv id_rsa id_rsa.pub ssh_config
