/* 
Chat GTP--
 1.   Let’s build a simple Node.js microservices project with RabbitMQ for communication between the product, order, and payment services.
 2.   Configure RabbitMQ to enable communication between services.

--------------Ubuntu/Debian Setup/Installation rabbitMQ--------------

    # Install dependencies
    sudo apt-get update
    sudo apt-get install -y curl gnupg

    # Add RabbitMQ repository
    curl -fsSL https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/gpg.key | sudo apt-key add -
    echo "deb https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-server/debian/ any-version main" | sudo tee /etc/apt/sources.list.d/rabbitmq.list

    # Install RabbitMQ
    sudo apt-get update
    sudo apt-get install -y rabbitmq-server

--------------Start and Enable RabbitMQ--------------

    # Start RabbitMQ
    sudo systemctl start rabbitmq-server

    # Enable RabbitMQ to start on boot
    sudo systemctl enable rabbitmq-server

    # Enable the management plugin
    sudo rabbitmq-plugins enable rabbitmq_management

    # Restart RabbitMQ to apply changes
    sudo systemctl restart rabbitmq-server

    # Status RabbitMQ 
    sudo systemctl status rabbitmq-server


--------------Used Commnad for create username and password--------------
    # Create a new user
    sudo rabbitmqctl add_user myuser mypassword

    # Set user tags (e.g., administrator)
    sudo rabbitmqctl set_user_tags myuser administrator

    # Set permissions for the new user
    sudo rabbitmqctl set_permissions -p / myuser ".*" ".*" ".*"


    sudo rabbitmqctl add_user myuser mypassword
    sudo rabbitmqctl set_user_tags myuser administrator
    sudo rabbitmqctl set_permissions -p / myuser ".*" ".*" ".*"
    sudo rabbitmqctl list_users

*/