#!/bin/bash

# Download and extract Flyway
sudo wget -qO- https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/10.9.1/flyway-commandline-10.9.1-linux-x64.tar.gz | tar -xvz 

# Create a symbolic link to make Flyway accessible globally
sudo ln -s $(pwd)/flyway-10.9.1/flyway /usr/local/bin

# Create the SQL directory for migrations
sudo mkdir sql

# Download the migration SQL script from AWS S3
aws s3 cp s3://shopwise-sql-files/V1__shopwise.sql sql/

# Run Flyway migration
sudo flyway -url=jdbc:mysql://"${RDS_ENDPOINT}"/"${RDS_DB_NAME}" \
  -user="${USERNAME}" \
  -password="${PASSWORD}" \
  -locations=filesystem:sql \
  migrate

# Then shutdown after waiting 7 minutes
sudo shutdown -h +12

// #!/bin/bash

// S3_URI=s3://shopwise-sql-files/V1__shopwise.sql
// RDS_ENDPOINT=dev-rds-db.cu2idoemakwo.us-east-1.rds.amazonaws.com
// RDS_DB_NAME=nestapp1db
// RDS_DB_USERNAME=cocoyo
// RDS_DB_PASSWORD=master1234

// # Update all packages
// sudo yum update -y

// # Download and extract Flyway
// sudo wget -qO- https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/10.9.1/flyway-commandline-10.9.1-linux-x64.tar.gz | tar -xvz 

// # Create a symbolic link to make Flyway accessible globally
// sudo ln -s $(pwd)/flyway-10.9.1/flyway /usr/local/bin

// # Create the SQL directory for migrations
// sudo mkdir sql

// # Download the migration SQL script from AWS S3
// sudo aws s3 cp "$S3_URI" sql/

// # Run Flyway migration
// flyway -url=jdbc:mysql://"$RDS_ENDPOINT":3306/"$RDS_DB_NAME" \
//   -user="$RDS_DB_USERNAME" \
//   -password="$RDS_DB_PASSWORD" \
//   -locations=filesystem:sql \
//   migrate