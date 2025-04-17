#Installing dependencies
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o docker.gpg

gpg --dearmor -o docker-archive-keyring.gpg docker.gpg
udo mv docker-archive-keyring.gpg /usr/share/keyrings/

 sudo mv docker-archive-keyring.gpg /usr/share/keyrings/

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
> https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
 tee /et> sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt update

   wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb
o dpkg -i packages-microsoft-prod.deb

 sudo dpkg -i packages-microsoft-prod.deb

 #install runtime
  sudo apt install -y aspnetcore-runtime-7.0

  wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
   chmod +x ./dotnet-install.sh
    ./dotnet-install.sh --version latest --runtime aspnetcore

#check for installation
     echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc
       source ~/.bashrc

        dotnet --info

#installing SDK
 sudo apt install -y dotnet-sdk-8.0
  wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh

  chmod +x dotnet-install.sh
  ./dotnet-install.sh --version latest

#Check installation
 dotnet --list-sdks

#Install Nginx
sudo apt update

 install nginx -y

sudo apt install nginx -y

#Start Nginx

sudo systemctl start nginx
sudo systemctl enable nginx

#Check if its running
sudo systemctl status nginx

#Clone the app
 git clone https://github.com/softwaregurukulamdevops/SGbookportal

 #Enter the directory
 cd SGbookportal #replace with the directory name 

 #Publish in the directory
 dotnet publish -c Release -o out

#Run the app manually
cd out

dotnet BookPortel.dll

#Create service file
sudo nano /etc/systemd/system/bookportel.service
#paste this there
[Unit]
Description=BookPortel ASP.NET Core App
After=network.target

[Service]
WorkingDirectory=/home/adetola/SGbookportal/out
ExecStart=/home/adetola/.dotnet/dotnet BookPortel.dll
Restart=always
RestartSec=10
SyslogIdentifier=bookportel
User=adetola
Environment=ASPNETCORE_ENVIRONMENT=Production

[Install]
WantedBy=multi-user.target
 #save and exit [ctrl + O, press enter then ctrl + X]

 #Reload and start the service 
 sudo systemctl daemon-reexec

sudo systemctl enable bookportel

sudo systemctl start bookportel

sudo systemctl status bookportel

#set up nginx reverse proxy
sudo nano /etc/nginx/sites-available/default

#Replace server block with this 
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
#save and exit [ctrl + O, press Y, press enter then ctrl + X]

#Test the configuration
sudo nginx -t

#Restart nginx
sudo systemctl restart nginx

#Run app in browser
http://localhost:5000/swagger
