push_demo: push_migrations
	scp target/openchs-server-0.1-SNAPSHOT.jar root@139.59.8.249:/root/openchs-host/app-server/openchs-server-0.1-SNAPSHOT.jar

push_migrations:
	scp ../openchs-server/src/main/resources/db/migration/*.sql root@139.59.8.249:/root/openchs-host/db/migration/

push_rules:
	cd ../lokbiradari-vhw && make package_rules
	scp -r ../lokbiradari-vhw/output/*.js root@139.59.8.249:/root/openchs-host/app-server/external/
	scp -r ../lokbiradari-vhw/deployables/*.json root@139.59.8.249:/root/openchs-host/app-server/external/

recreate-db:
	flyway -user=openchs -password=password -url=jdbc:postgresql://localhost:5432/openchs -schemas=openchs clean
	flyway -user=openchs -password=password -url=jdbc:postgresql://localhost:5432/openchs -schemas=openchs -locations=filesystem:./db/migration/ migrate

run_app_server:
	nohup java -XX:ErrorFile=./app-server/log/jvm.log -jar ./app-server/openchs-server-0.1-SNAPSHOT.jar > app-server/log/openchs-server.log 2>&1 &

setup_metadata:
	cd ../lokbiradari-vhw && make setup-health-modules setup-impl-db