
ECHO OFF
CLEAR

ECHO "Hello, World!"

ECHO "Downloading Discovery System..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-discovery-system.git

ECHO "Downloading Loading Balancer..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-load-balancer.git

ECHO "Downloading Product Command..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-product-command.git

# ECHO "Downloading Product Query..."
# git clone https://github.com/INSIS-s-Projects-ISEP/acme-product-query.git

ECHO "Downloading Review Command..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-review-command.git

ECHO "Downloading Review Query..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-review-query.git

ECHO "Downloading Vote Command..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-vote-command.git

ECHO "Downloading Vote Query..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-vote-query.git

ECHO "Running docker-compose.yml file..."
docker compose up -d --build

PAUSE
