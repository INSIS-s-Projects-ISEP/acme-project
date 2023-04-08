
echo off
clear

echo
echo "Preparing environment..."
cd ..

echo
echo "Downloading Discovery System..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-discovery-system.git

echo
echo "Downloading Loading Balancer..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-load-balancer.git

echo
echo "Downloading Product Command..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-product-command.git

# echo
# echo "Downloading Product Query..."
# git clone https://github.com/INSIS-s-Projects-ISEP/acme-product-query.git

echo
echo "Downloading Review Command..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-review-command.git

echo
echo "Downloading Review Query..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-review-query.git

echo
echo "Downloading Vote Command..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-vote-command.git

echo
echo "Downloading Vote Query..."
git clone https://github.com/INSIS-s-Projects-ISEP/acme-vote-query.git

echo
echo "Running docker-compose.yml file..."

cd ./acme-project
docker compose up -d --build

echo
read -p "Press any key to resume..."
