from flask import Flask, jsonify
from flask_cors import CORS  # Import CORS
from kubernetes import client, config
from kubernetes.config.config_exception import ConfigException

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

@app.route('/api/pods', methods=['GET'])
def get_pods():
    try:
        # Load the kubeconfig file
        try:
            config.load_kube_config()
        except ConfigException as e:
            return jsonify({"error": "Could not load kubeconfig: " + str(e)}), 500

        # Create an instance of the CoreV1Api
        v1 = client.CoreV1Api()

        # Fetch the list of pods from all namespaces
        pods = v1.list_pod_for_all_namespaces(watch=False)

        # Prepare the list of pods to return as JSON
        pod_list = []
        for pod in pods.items:
            pod_info = {
                "name": pod.metadata.name,
                "namespace": pod.metadata.namespace,
                "status": pod.status.phase,
                "node": pod.spec.node_name,
                "start_time": str(pod.status.start_time)  # Convert to string to ensure JSON serialization
            }
            pod_list.append(pod_info)

        return jsonify(pod_list)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)  # Ensure this matches your desired IP and port