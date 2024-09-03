// https://huzzefakhan.medium.com/install-and-setup-apache-kafka-on-linux-b430d8796dae

/* 1. Install Java
    sudo apt update
    sudo apt install openjdk-11-jdk
    java -version
*/

/* 2. Download and Extract Kafka

    https://kafka.apache.org/downloads  (Click on any of the binary downloads)

    wget https://downloads.apache.org/kafka/3.8.0/kafka_2.13-3.8.0.tgz
    tar xzf kafka_2.13-3.8.0.tgz
    sudo mv kafka_2.13-3.8.0 /usr/local/kafka
*/


/* 3. Configure Kafka
    Server Configuration (server.properties):
        // bash---
            nano /usr/local/kafka/config/server.properties

        // Ensure these lines are configured (modify if necessary):
            broker.id=0
            listeners=PLAINTEXT://localhost:9092
            log.dirs=/tmp/kafka-logs
            zookeeper.connect=localhost:2181

    Zookeeper Configuration (zookeeper.properties):
        // bash---
            nano /usr/local/kafka/config/zookeeper.properties

        // Ensure these lines are configured (modify if necessary):
            dataDir=/tmp/zookeeper
            clientPort=2181

*/

/* 4. Verify Kafka Installation
    // Create a topic:

    cd /usr/local/kafka
    bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic myTopic

    Created topic myTopic.

*/

/* Step 5 — Creating System Unit Files
    // base--
        nano /etc/systemd/system/zookeeper.service

    // And add the following content:

        [Unit]
        Description=Apache Zookeeper server
        Documentation=http://zookeeper.apache.org
        Requires=network.target remote-fs.target
        After=network.target remote-fs.target

        [Service]
        Type=simple
        ExecStart=/usr/local/kafka/bin/zookeeper-server-start.sh /usr/local/kafka/config/zookeeper.properties
        ExecStop=/usr/local/kafka/bin/zookeeper-server-stop.sh
        Restart=on-abnormal

        [Install]
        WantedBy=multi-user.target


    // base--
        nano /etc/systemd/system/kafka.service

    // And add the following content:

        [Unit]
        Description=Apache Kafka Server
        Documentation=http://kafka.apache.org/documentation.html
        After=network.target zookeeper.service

        [Service]
        Type=simple
        ExecStart=/usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties
        ExecStop=/usr/local/kafka/bin/kafka-server-stop.sh
        Restart=on-abnormal

        [Install]
        WantedBy=multi-user.target

/*

/*6&8 Reload the systemd daemon to apply new changes.

    sudo systemctl enable zookeeper
    sudo systemctl enable kafka

    sudo systemctl start zookeeper
    sudo systemctl start kafka

    sudo systemctl daemon-reload
    sudo systemctl restart kafka


    sudo systemctl status kafka
    sudo systemctl status zookeeper

*/


/* 7. Start Kafka and Zookeeper
    /usr/local/kafka/bin/zookeeper-server-start.sh /usr/local/kafka/config/zookeeper.properties
    
    Open a new terminal window and start Kafka:
    /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties

*/

// bin/kafka-topics.sh --create --topic test --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1


