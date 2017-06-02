push-demo: push-migrations
	scp target/openchs-server-0.1-SNAPSHOT.jar root@139.59.8.249:/root/openchs-host/app-server/openchs-server-0.1-SNAPSHOT.jar

push-migrations:
	scp ../openchs-server/src/main/resources/db/migration/*.sql root@139.59.8.249:/root/openchs-host/db/migration/

recreate-db:
	flyway -user=openchs -password=password -url=jdbc:postgresql://localhost:5432/openchs -schemas=openchs clean
	flyway -user=openchs -password=password -url=jdbc:postgresql://localhost:5432/openchs -schemas=openchs -locations=filesystem:./db/migration/ migrate