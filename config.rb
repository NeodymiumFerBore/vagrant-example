# If IMAGE is changed, the removed default entry from /etc/hosts
# might need to be changed in scripts/setup-hosts.sh
IMAGE = "ubuntu/jammy64"
MEMORY = 2048
CPUS = 2

# NOTE:
# If node counts or IP settings are changed,
# remember to update scripts/setup-hosts.sh accordingly

# Define the number of master and worker nodes
MASTER_NODE_COUNT = 1
WORKER_NODE_COUNT = 2

# Will be /24
# To use a Host-Only network, IP_NW must match
# an already existing host-only network scope
# When using an internal network, can be anything
IP_NW = "10.0.0."
MASTER_IP_START = 10 # master01 will be this +1
WORKER_IP_START = 20 # node01 will be this +1

INTERNAL_NET_NAME = "k8s"
