# Scales instances of hey 

NUM_INSTANCES=$1
IMAGE=$2
URL=$3

# Check args
if [[ -z "$1"  ||  -z "$2" || -z "$3" ]];
then
  echo "Invalid syntax. Correct is: ./hey_scaler.sh <num_instances> <image> <url>"
  echo "<num_instances> is the number of instances to scale to. For example, 10 or 1000"
  echo "<image> is the fully qualified GCR path of they image with a hey entrypoint"
  echo "<url> to send requests to"
  exit 1
fi

# Make a directory to contain generated Kubernetes job deployments.
if [ -d jobs ]; then
  kubectl delete -f ./jobs 
  rm ./jobs/*
fi

if [ ! -d jobs ]; then
  mkdir ./jobs 
fi

for ((i=1; i<$NUM_INSTANCES; i++))
do 
  cat kubernetes_job.yaml | sed "s~\$NUM~$i~g; s~\$URL~$URL~g; s~\$IMAGE~$IMAGE~g" >> jobs/hey-job-$i.yaml
done

 kubectl create -f ./jobs
