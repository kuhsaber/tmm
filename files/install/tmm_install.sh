#!/bin/bash

#########################################
##  FILES, SERVICES AND CONFIGURATION  ##
#########################################

# X app start script
cat <<'EOT' > /startapp.sh
#!/bin/bash

cd /tinyMediaManager
java -Djava.net.preferIPv4Stack=true -jar getdown.jar .
EOT

# tmm config
cat <<'EOT' > /etc/my_init.d/04_tmm_config.sh
#!/bin/bash
[[ ! -d /config ]] && mkdir /config
[[ ! -d /config/log ]] && mkdir /config/log
[[ ! -d /config/logs ]] && mkdir /config/logs
[[ ! -d /config/backup ]] && mkdir /config/backup
[[ ! -e /config/launcher.log ]] && touch /config/launcher.log
[[ ! -e /config/config.xml ]] && cp /tmmConfig/config.xml /config/config.xml
[[ ! -e /config/tmm.odb ]] && cp /tmmConfig/tmm.odb /config/tmm.odb
[[ ! -L /tinyMediaManager/log ]] && ln -s /config/log /tinyMediaManager/log
[[ ! -L /tinyMediaManager/logs ]] && ln -s /config/logs /tinyMediaManager/logs
[[ ! -L /tinyMediaManager/backup ]] && ln -s /config/backup /tinyMediaManager/backup
[[ ! -L /tinyMediaManager/launcher.log ]] && ln -s /config/launcher.log /tinyMediaManager/launcher.log
[[ ! -L /tinyMediaManager/config.xml ]] && ln -s /config/config.xml /tinyMediaManager/config.xml
[[ ! -L /tinyMediaManager/tmm.odb ]] && ln -s /config/tmm.odb /tinyMediaManager/tmm.odb

chown -R root: /config /tinyMediaManager /root || exit 0
EOT

chmod -R +x /etc/service/ /etc/my_init.d/

#########################################
##             INSTALLATION            ##
#########################################

# Install tinyMediaManager
mv /tmp/tmmConfig /tmmConfig
