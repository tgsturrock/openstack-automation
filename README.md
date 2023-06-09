ELE796
Laboratoire 2 - Mise en œuvre d’une infrastructure virtuelle par OpenStack

Dans ce laboratoire, vous êtes demandé(e) de créer et configurer une infrastructure 
virtuelle en utilisant OpenStack, et plus particulièrement le programme 
d’installation DevStack. Vous devez générer des machines virtuelles pour les 
utilisateurs finaux, chaque utilisateur peut avoir un nombre des machines avec 
la capacité au besoin. Ces machines doivent être générées automatiquement par 
un programme, et elles sont isolées par des réseaux différents. Ceci sera 
achevé en utilisant le client en ligne de commande et les outils 
d’automatisation d’OpenStack.

Dans ce laboratoire, vous devez créer un ensemble de trois (03) machines virtuelles (VMs) à partir de l’image ISO Ubuntu 20.04 TLS 64bit. Les images ISO peuvent être téléchargé à partir de :
https://releases.ubuntu.com/20.04/

Ensuite, vous devez installer OpenStack dans ces machines virtuelles pour les 
virtualiser, en utilisant DevStack. Parmi ces 3 VMs, une va héberger le nœud 
de contrôle (control node), et deux nœuds restants sont les nœuds de calcul 
(compute nodes). Le nœud de contrôle doit contenir tous les composants 
principaux d’OpenStack, tels que Keystone, Nova, Neutron, Glance, Horizon, 
et aussi Heat pour l’orchestration de l’infrastructure virtuelle.
