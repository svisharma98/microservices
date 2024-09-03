const express = require('express');
const amqp = require('amqplib');
const app = express();
app.use(express.json());

/*
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


let rUrl = "amqp://myuser:mypassword@localhost:5672/"
// rUrl= "'amqp://myuser:mypassword@localhost'"

async function connectRabbitMQ() {
    const connection = await amqp.connect(rUrl);

    const channel = await connection.createChannel();
    await channel.assertQueue('orderQueue');
    return channel;
}

app.get('/product', (req, res) => {
    res.send('Product Service');
});

app.get('/product/order', async (req, res) => {
    const channel = await connectRabbitMQ();
    console.log("Call Product order api")
    const order = `${new Date()}, send to order` // req.body;
    await channel.sendToQueue('orderQueue', Buffer.from(JSON.stringify(order)));
    res.send('Order sent to Order Service');
});

app.listen(3000, () => console.log('Product Service running on port 3000'));
