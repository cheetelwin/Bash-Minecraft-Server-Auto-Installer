#!/bin/bash
clear
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "
<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>
^     Minecraft Craftbukkit 	^
^   Server Setup + auto-Scrips	^
^        By: boom2777777	^
^     Scripts by: gravypod	^
^     Supported OS's (So Far)	^
^ (v0.1) Debian & Ubuntu 	^
<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>


|-------------------------------|
|	     ((Menu))		|
|				|
|1. Install	2. Update 	|	
|3. Uninstall	4. Exit		|
|-------------------------------|"
read Menu
case "$Menu" in
[1]	)	clear
		echo "
|-------------------------------|
|	  	  	((RAM))				|
|	 	 (*Recomended)			|
|				 				|
|   1. 512 MB*	2. 1024 MB*	    |
|   3. 1536 MB*	4. 2048 MB	    |
|   5. 2560 MB 	6. 3072 MB	    |
|        7. Custome		        |
|	 (Add m for MB, G for GB)   |
|-------------------------------|"
		read RAM
		case "$RAM" in
			[1] ) DRAM="512";;
			[2] ) DRAM="1024";;
			[3] ) DRAM="1536";;
			[4] ) DRAM="2048";;
			[5] ) DRAM="2560";;
			[6] ) DRAM="3072";;
			[7] ) read DRAM
echo "
|-------------------------------|
|	  	  	((CPU))				|
|	 	 (*Recomended)			|
|				 				|
|   1. 1 CPU  	2. 2 CPU  	    |
|   3. 3 CPU   	4. 4 CPU  	    |
|   5. 5 CPU   	6. 6 CPU  	    |
|        7. Custome		        |
| (The amount of cores to use)  |
|-------------------------------|"
		read CPU
		case $CPU
			[1] ) CPU="1";;
			[2] ) CPU="2";;
			[3] ) CPU="3";;
			[4] ) CPU="4";;
			[5] ) CPU="5";;
			[6] ) CPU="6";;
			[7] ) read CPU
		esac
		clear
		echo "Checking Sudo is installed"
		if dpkg-query -W sudo; then
			echo "sudo is installed";
		else 
			echo "Installing sudo"
			echo "## Begining Apt sudo ##" >> MCInstallLog.txt
			apt-get install sudo;
			
		fi
		echo "Checking sudo Access"
		sudo echo "Success" 
		sleep 1
		echo "Checking if crontab is installed"
		if dpkg-query -W cron; then
			echo "cron is installed";
		else
			echo "Installing cron"
			sudo apt-get install cron;
		fi
		sleep 1
		echo "Checking if screen is installed"
		if dpkg-query -W screen; then
			echo "screen is installed";
		else
			echo "Installing screen"
			sudo apt-get install screen
			echo startup_message off >> /etc/screenrc;
		fi
		sleep 1
		sleep 1
		echo "Checking if screen is installed"
		if dpkg-query -W zip; then
			echo "zip is installed";
		else
			echo "Installing zip"
			sudo apt-get install zip;
		fi
		sleep 1
		echo "Checking if rdiff/rdiff-backup is installed"
		if dpkg-query -W rdiff; then
			echo "rdiff is installed";
		else
			echo "Installing rdiff"
			sudo apt-get install rdiff;
		fi
		if dpkg-query -W rdiff-backup; then
			echo "rdiff-backup is installed";
		else
			echo "Installing rdiff-backup"
			sudo apt-get install rdiff-backup;
		fi
		sleep 1
				echo "Checking if mysql-server/mysql-client is installed"
		if dpkg-query -W mysql-server; then
			echo "mysql-server is installed";
		else
			echo "Installing mysql-server"
			sudo apt-get install mysql-server;
		fi
		if dpkg-query -W mysql-client; then
			echo "mysql-client is installed";
		else
			echo "Installing mysql-client"
			sudo apt-get install mysql-client;
		fi
       	 	sleep 2
		clear
		cd $DIR
		mkdir backup
		mkdir backup/MC
		mkdir scripts
		mkdir minecraft
		mkdir logs
		touch MCInstallLog.txt
		echo "Grabbing craftbukkit.jar"
			echo "## Begining wget ##" >> MCInstallLog.txt
			wget http://dl.bukkit.org/downloads/craftbukkit/get/latest-rb/craftbukkit.jar ./craftbukkit.jar > MCInstallLog.txt
		clear
		echo "Got craftbukkit.jar"
		sleep 1
		echo "Writing Scripts"
		quote='\042'
		delta='\044'
		nln='\134''\162'
		sleep 1
		echo "Daily Backup Script"
		echo "## Begining Scripts ##" >> MCInstallLog.txt
		touch scripts/backupday.sh
sudo echo -e "#!/bin/bash/
cd $DIR
screen -S minecraft -p world -X stuff $quote""say Starting daily backup.$quote\140echo '$nln'\140
sleep 1
T=$quote$delta(date +%s)$quote
screen -S minecraft -p world -X stuff $quote""save-all$quote\140echo '$nln'\140
sleep 2
screen -S minecraft -p world -X stuff $quote""save-off$quote\140echo '$nln'\140
sleep 1
T=$quote $delta(($delta(date +%s)-T))$quote
D=$quote $delta(date +%y-%m-%d)$quote
cp -r $DIR/world $DIR/backup/MC/world[$delta{D}]/
cp -r $DIR/world_nether/ $DIR/backup/MC/world_the_end[$delta{D}]/
cp -r $DIR/world_the_end/ $DIR/backup/MC/world_the_end[$delta{D}]/ 
cp -r $DIR/plugins/ $DIR/backup/MC/plugins[$delta{D}]/
T=$quote$delta(($delta(date +%s)-T))$quote
screen -S minecraft -p world -X stuff $quote""save-on$quote\140echo '$nln'\140
sleep 1
screen -S minecraft -p world -X stuff $quote""save-all$quote\140echo '$nln'\140
sleep 2
screen -S minecraft -p world -X stuff $quote""say Daily backup complete.  Completed in $delta{T}s.$quote\140echo '$nln'\140
sleep 2
D=$quote $delta(date +%y-%m-%d)$quote
cp $DIR/server.log $DIR/backup/MC/server.log
touch server.log
sleep 30
exit $delta?" > backupday.sh
		chmod 777 backupday.sh
		echo "## backupday.sh written ##" >> MCInstallLog.txt
		sleep .5
		echo "Hourly Backup Script"
		touch scripts/backuphr.sh
sudo echo -e "#!/bin/bash
cd $DIR
T=$quote $delta(date +%s)$quote
screen -S minecraft -p world -X stuff $quote""say Starting hourly backup, expect some lag!$quote\140echo '$nln'\140
sleep 1
T=$quote $delta(($delta(date +%s)-T))$quote
D=$quote $delta(date +%y-%m-%d)$quote
rdiff-backup ./world ./backup/MC/world/
rdiff-backup ./plugins ./backup/MC/plugins/
cp ./banned-players.txt ./backup/MC/bans/banned-players[$delta{D}].txt
cp ./banned-players.txt ./backup/MC/banned-players[$delta{D}].txt
cp ./server.log ./backup/MC/server[$delta{D}].log
T=$quote $delta(($delta(date +%s)-T))$quote
sleep 1
screen -S minecraft -p world -X stuff $quote""say Backup complete.  Completed on $delta{D}s$quote\140echo '$nln'\140
exit $delta?" > backuphr.sh
                chmod 777 backuphr.sh
		echo "## backuphr.sh written ##" >> MCInstallLog.txt
		sleep .5
		echo "Server Restart Script"
		touch scripts/restart.sh
sudo echo -e "#!/bin/bash/

cd $DIR
screen -S minecraft -p world -X stuff $quote""say Restarting in 30!$quote\140echo '$nln'\140
sleep 10
screen -S minecraft -p world -X stuff $quote""say Restarting in 20s!$quote\140echo '$nln'\140
sleep 10
screen -S minecraft -p world -X stuff $quote""say Restarting in 10s!$quote\140echo '$nln'\140
sleep 10
screen -S minecraft -p world -X stuff $quote""kickall Server Restart$quote\140echo '$nln'\140
sleep 1
screen -S minecraft -p world -X stuff $quote""stop$quote\140echo '$nln'\140" > restart.sh 
		chmod 777 restart.sh
		echo "## restart.sh written ##" >> MCInstallLog.txt
		sleep .5
		echo "Server Start Script"
		touch scripts/serverstart-main.sh
sudo echo -e "#!/bin/bash
while :
do
java -server -Xincgc -Xmx$DRAM -Xms$DRAM -XX:+UseFastAccessorMethods -XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -jar craftbukkit.jar
done" > serverstart-main.sh
                chmod 777 serverstart-main.sh
		echo "## serverstart-main.sh written ##" >> MCInstallLog.txt
		sleep .5
		echo "Runner Script"
		touch runner.sh
sudo echo -e "#!/bin/sh
echo Server Setup
killall java
killall screen
killall craftbukkit
screen -wipe
sleep 2
echo Starting Server and Screen 
screen -dmS minecraft -t world -m $DIR/serverstart-main.sh
sleep 1
echo Server Started, Attaching
sleep 2

screen -x" > runner.sh
		chmod 777 runner.sh
		echo "## runner.sh written ##" >> MCInstallLog.txt
		sleep .5
		echo "Server Save Script"
		touch save.sh
sudo echo -e "#!/bin/bash
cd $DIR
screen -S minecraft -p world -X stuff $quote""save-all$quote\140echo '$nln'\140
exit $delta?" > save.sh 
		chmod 777 save.sh
		echo "## save.sh written ##" >> MCInstallLog.txt
		sleep .5
		echo "Server Stop Script"
		touch scripts/stop.sh
sudo echo -e "#!/bin/bash/
screen -S minecraft -p world -X stuff $quote""say Full server restart! Server will restart in 10 secconds!$quote\140echo '$nln'\140
sleep 10
screen -S minecraft -p world -X stuff $quote""say Full stop!!!$quote\140echo '$nln'\140
sleep 1
screen -S minecraft -p world -X stuff $quote""kickall Server restart, some back in 5-10 minutes$quote\140echo '$nln'\140
sleep 1
screen -S minecraft -p world -X stuff $quote""stop$quote\140echo '$nln'\140
killall -9 screen
killall -9 java" > stop.sh
		chmod 777 stop.sh
		echo "## stop.sh written ##" >> MCInstallLog.txt
		sleep .5
		echo "Crontab Setup "
		crontab -l > crondump
		echo @reboot $DIR/runner.sh >> crondump
		echo @hourly $DIR/scripts/restart.sh >> crondump
		echo @hourly $DIR/scripts/backuphr.sh >> crondump
		echo @daily  $DIR/scripts/backupday.sh >> crondump
		echo @hourly $DIR/scripts/save.sh >> crondump
		### INSTALL JAVA 7! ##
		clear
				echo "
|--------------------------------|
|    ((What Os do you use?))	 |
|	((Java Install))	 |
|				 |
|1. Debian(x86)			 |
|2. Ubuntu(x86)			 |
|3. No java for me		 |
|--------------------------------|"
	read jinstall
	case "$jinstall" in
	[1] ) clear
			echo "
Installing java!
+        o     o       +        o
-_-_-_-_-_-_-_,------,      o 
_-_-_-_-_-_-_-|   /\_/\  
-_-_-_-_-_-_-~|__( ^ .^)  +     +  
-_-_-_-_-_-_-_-_-""  ""      
+      o         o   +       o"
		wget http://download.oracle.com/otn-pub/java/jdk/7/jdk-7-linux-x64.tar.gz ./jdk7.tar.gz
		mkdir /usr/lib64/jvm/
		tar zxvf jdk-7-linux-x64.tar.gz -C /usr/lib64/jvm/
		update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0/bin/java 1065
		update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0/bin/javac 1065
		echo "
		
		Click 2!!!!
		
		
		"
		update-alternatives --config java
		java -version
		sleep 1
		echo "Does that say 1.7.0?";;
	[2] ) clear 
		## sun java 6 should be the one that works on ubuntu ##
		if dpkg-query -W sun-java6-jdk; then
		echo "You already have Java installed"
		else 
		echo "Installing sun-java6-jdk"
		sudo apt-get install sun-java6-jdk;;
		
		
		
	esac
	sleep 2
	echo "
		|--------------------------------|
		|   Do you want apache2?         |
		|				 |
		|1. Yes apache2   		 |
		|2. No apache2                   |
		|				 |
		|--------------------------------|"
	read apaInstall
		case $apaInstall
			[1] ) clear 
				sudo apt-get install apache2 
				apt-get install php5-common libapache2-mod-php5 php5-cli
				apt-cache search php5
				sudo apt-get install apache2-mpm-prefork
				sudo /etc/init.d/apache2 restart;;
		esac		
		echo "
				
|-------------------------------|
|   Do you want a map renderer? |
|				|
|1. Yes Map render?		|
|2. No Map render?		|
|				|
|-------------------------------|"
				read mapRender
				case $mapRender
				[1] ) clear 
					sudo deb http://overviewer.org/debian ./
					sudo apt-get update
					sudo apt-get install minecraft-overviewer
					touch maprender.sh
					mkdir /var/www/map
					echo -e "#!/bin/bash/
					overviewer.py --rendermodes=smooth-lighting $DIR/world /var/www/map/
					"
		echo "
				
|-------------------------------|
| How often do you want to cook?|
|				|
|1. monthly     		|
|2. weekly      		|
|3.daily			|
|4. hourly			|
|-------------------------------|"
				read cookCron
						case $cookCron
						[1] ) cronmap="@monthly";;
						[2] ) cronmap="@weekly";;
						[3] ) cronmap="@daily";;
						[4] ) cronmap="@hourly";;
				echo $cronmap $DIR/scripts/maprenter.sh >> crondump;;
				[2] ) clear ;;
	case $apaInstall
	[2] ) clear ;;
		sleep .5
		echo "Server Startup test!"
		touch tempStart.sh
		echo -e "#!/bin/bash/
java -jar craftbukkit.jar" > tempStart.sh
		chmod 0777 tempStart.sh
		screen -wipe >> MCInstallLog.txt
		screen -dmS minecraft -t world -m ./tempStart.sh 
		sh stop.sh
		### Begin plugins ###
		echo "Success!"
		sleep 1
		clear
		echo "
|-------------------------------|
|      ((Optonal Plugins))	|
|				|
|1. Yes Please!			|
|2. No Thanks...		|
|-------------------------------|"
		read PluginMenu
		case "$PluginMenu" in

		[1] )	clear
			cd $DIR/plugins
			wget http://tiny.cc/EssentialsZipDownload ./essentials.zip
			unzip $DIR/plugins/EssentialsZipDownload
			sleep 5
			rm EssentialsZipDownload
			cd ../
			clear
			echo "Initializing Plugins"
			screen -wipe >> MCInstallLog.txt
			screen -dmS minecraft -t world -m ./tempStart.sh
			sleep 10
			sh stop.sh
			echo "Server Installed using boom277777777's Awesome Installer" >> $DIR/plugins/Essentials/motd.txt
			sleep 5
			rm tempStart.sh
			echo "Plugins Installed";;
		[2] ) 	rm tempStart.sh
			echo "Plugins Not Installed";;
		esac
		exit;;
		crontab crondump >> MCInstallLog.txt
		rm crondump
	[2] )	clear
		echo "Starting Update "$(date +%y-%m-%d)""
		echo "## Begining Update "$(date +%y-%m-%d)" ##" >> MCInstallLog.txt
		echo "Killing server"
		cd $DIR
		sh save.sh
		sleep 2
		sh stop.sh
		echo "Grabbing new jar"
		echo "## Begining wget ##" >> MCInstallLog.txt
			rm craftbukkit.jar
                        wget http://cbukk.it/craftbukkit.jar ./craftbukkit.jar >> MCInstallLog.txt
		echo "## ending wget ##" >> MCInstallLog.txt
		clear
		echo "Update Finished, Exiting"
		echo "## Ending Update "$(date +%y-%m-%d)" ##" >> MCInstallLog.txt
		exit;;

[3]	)	clear
		cd $DIR
		echo "Uninstall running"
		killall -9 java
		killall -9 screen
		sleep 1
		rm $DIR/backupday.sh 
		rm $DIR/backuphr.sh 
		rm $DIR/restart.sh 
		rm $DIR/runner.sh 
		rm $DIR/save.sh 
		rm $DIR/serverstart-main.sh 
		rm $DIR/stop.sh
		rm $DIR/white-list.txt 
		rm $DIR/ops.txt
		rm $DIR/bukkit.yml
		rm $DIR/banned-ips.txt
		rm $DIR/help.yml
		rm $DIR/permissions.yml
		rm $DIR/server.log
		rm $DIR/banned-players.txt
		rm $DIR/craftbukkit.jar
		rm $DIR/server.properties
		rm $DIR/server.log.lck
		touch crontabReset 
		crontab crontabReset
		rm crontabReset
		rm -r world/
		rm -r world_nether/
		rm -r world_the_end/
		rm -r backup/ 
		rm -r plugins/
		sleep 1
		rm $DIR/MCInstallLog.txt
		clear
		echo "Done!"
		exit;;

[4]	)	clear
		exit;;
esac

