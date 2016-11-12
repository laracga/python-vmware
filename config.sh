
email_recipient="laracg.mar@gmail.com"

#Sistemas operativos
declare -a os=("centos" "redhat" "debian" "ubuntu")

#Versiones
declare -a version_centos=("6.7" "7.1.*")
declare -a version_redhat=("6.6" "6.7" "7.2")
declare -a version_debian=("7.*" "8.*")
declare -a version_ubuntu=("14.04" )

#Queries de Chef para cada ventana

declare -a ventana_pre_domingo_00_04=("chef_environment:pc_pre")
declare -a ventana_pro_domingo_07_11=("chef_environment:pc_prd" "chef_environment:proyecto_prd")

