### Hey Scaler


#### Description
This script allows you to scale the hey web request utility to N number of Kubernetes pods by populating args into a template and creating jobs for each. This script assumes you're in Google Cloud Shell or another environment with the gcloud sdk and kubectl.  

#### Usage
First create a kubernetes cluster
```
gcloud container clusters create heycluster
```
Build the image and make available in GCR
```
gcloud builds submit --tag=gcr.io/heyproject/heyscaler .
```
Once it's up, run the scaler
```
./hey_scaler.sh 65 gcr.io/heyproject/heyscaler:latest "https://helloservice-pnya2ti5ka-uc.a.run.app"
```
The above will create 65 containers that attempt to send 1000 concurrent requests each to the specified URL for 10 minutes. 
The scaler uses a job template to create N number of short lived jobs in your Kubernetes cluster that all run concurrently. Currently assumes the cluster you created is your default. Modify the command in the template with command flags from [hey](https://github.com/rakyll/hey) as needed.  

More to be added...
