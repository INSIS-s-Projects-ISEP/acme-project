
ECHO OFF
CLEAR

ECHO "Hello, World!"

ECHO "Downloading Discovery System..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-discovery-system.git

ECHO "Downloading Loading Balancer..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-load-balancer.git

ECHO "Downloading Product Command..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-product-command.git

ECHO "Running docker-compose.yml file..."
docker compose up -d --build

PAUSE
