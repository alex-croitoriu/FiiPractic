Vagrant.configure("2") do |config|

    os = "rockylinux/9"
    ho_net = "192.168.100"
    config.vm.synced_folder '.', '/vagrant', disabled: true
	
	# Configurare FiiPractic-App
	
	config.vm.define :app do |app_config|
        app_config.vm.provider "virtualbox" do |vb|
            vb.memory = "2048"
            vb.cpus = 2
            vb.name = "FiiPractic-App"
        end
        app_config.vm.host_name = 'app.fiipractic.lan'
        app_config.vm.box = "#{os}"
        app_config.vm.network "private_network", ip: "#{ho_net}.10"
        # app_config.vm.network "public_network", ip: "#{ho_net}.10", bridge: "MediaTek Wi-Fi 6 MT7921 Wireless LAN Card"
        app_config.vm.provision "shell", inline: <<-SHELL
            echo "root:fiipractic" | chpasswd
            sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
            sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
            systemctl restart sshd
            yum install -y git
            yum install -y wget
            yum install -y vim
            yum install -y nano

            # Adaugare cheie publica SSH
            
            echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARd3WzWLnB3vuF6Vl4/hCt+MU4khgGUYZNkcDGz5AZM Alex@DESKTOP-CPP11MI" >> /root/.ssh/authorized_keys
        SHELL
    end
	
	# Configurare FiiPractic-GitLab
	
	config.vm.define :gitlab do |gitlab_config|
        gitlab_config.vm.provider "virtualbox" do |vb|
            vb.memory = "8192"
            vb.cpus = 6
            vb.name = "FiiPractic-GitLab"
        end
        gitlab_config.vm.disk :disk, size: "40GB", primary: true
        gitlab_config.vm.host_name = 'gitlab.fiipractic.lan'
        gitlab_config.vm.box = "#{os}"
        gitlab_config.vm.network "private_network", ip: "#{ho_net}.20"
        # gitlab_config.vm.network "public_network", ip: "#{ho_net}.20", bridge: "MediaTek Wi-Fi 6 MT7921 Wireless LAN Card"
        gitlab_config.vm.provision "shell", inline: <<-SHELL
            echo "root:fiipractic" | chpasswd
            sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
            sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
            systemctl restart sshd
            yum install -y git
            yum install -y wget
            yum install -y vim
            yum install -y nano

            # Adaugare cheie publica SSH

            echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARd3WzWLnB3vuF6Vl4/hCt+MU4khgGUYZNkcDGz5AZM Alex@DESKTOP-CPP11MI" >> /root/.ssh/authorized_keys
        SHELL
	end
end
