/*
#!/bin/
 # Add the PostgreSQL repository
  yum install -y https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-7-x86_64/pgdg-centos12-12-2.noarch.rpm 
  # Install PostgreSQL 12
   yum install -y postgresql12-server postgresql12
    # Initialize the PostgreSQL database 
    /usr/pgsql-12/bin/postgresql-12-setup initdb 
    # Enable and start the PostgreSQL service
     systemctl enable postgresql-12
      systemctl start postgresql-12 
*/


#!/bin/bash 
# Add the PostgreSQL repository
 yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
# Install PostgreSQL 12 
yum install -y postgresql12-server                      #postgresql12 
# Initialize the PostgreSQL database 
/usr/pgsql-12/bin/postgresql-12-setup initdb 
# Enable and start the PostgreSQL service 
systemctl enable postgresql-12 
systemctl start postgresql-12