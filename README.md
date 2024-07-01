ELE796
Laboratoire 2 - Mise en œuvre d’une infrastructure virtuelle par OpenStack

Trois VM on été configurer sur Openstack, soit control-node, compute-node1, compute-node2.

Leurs addresses IP sont les suivants:

    control-node: 192.168.122.252
    compute-node1: 192.168.122.139 
    compute-node2: 192.168.122.123


OpenStack a été installé sur les 3 nodes.

Afin d'accéder au compte admin du OpenStack utiliser les information suivantes:

    User: admin
    pass: ubuntu


Un template Heat est utiliser afin de crer 4 VMs.
Le nom des VMs et les ip de leurs sous-réseaux:

    VM1_Compute1 192.168.10.0/24
    VM2_Compute1 172.24.15.0
    VM3_Compute2 192.168.10.0/24
    VM4_Compute2 172.24.15.0

Afin de valider leurs connexion, il s'agit de rentrer dans l'interface horizon 
à l'adresse suivante http://192.168.122.252/dashboard/ et entrer dans la console de une
des instance puis envoyer un ping vers l'instance qui est sur le meme sous-réseau.
