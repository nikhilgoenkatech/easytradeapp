import sys
import docker

def stop_docker_service(service_name):
    try:
        client = docker.from_env()
        service = client.services.get(service_name)
        service.remove()
        print(f"Stopped Docker service: {service_name}")
    except docker.errors.NotFound:
        print(f"Docker service not found: {service_name}")
    except docker.errors.APIError as e:
        print(f"Error stopping Docker service: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python stop_docker_service.py <service_name>")
        sys.exit(1)

    service_to_stop = sys.argv[1]
    stop_docker_service(service_to_stop)
