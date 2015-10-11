# According to http://blog.titocosta.com/post/110345699197/public-ec2-ami-with-torch-and-caffe-deep-learning
open https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-ffba7b94
# pick g2.2xlarge
# Request Spot Instances
# Availability Zone: whichever is cheapest
# Maximum price $1.
# Next: Add Storage. Default 60GB is fine.
# Next: Tag. Name:reuse-caffe-test2 is fine.
# Next: Configure Security Group. Default ssh-from-everywhere is fine.
# Launch.
# Choose an existing key pair: reuse-elasticsearch.
# Wait until fulfilled. Click on instance. Check public DNS.

dns=ec2-52-91-246-221.compute-1.amazonaws.com
pem=~/Downloads/keypair1.pem
# Don't forget to chmod go-rwx $pem

# Change 'danielvarga' so that this points to your fork:
ssh -i $pem ubuntu@$dns wget https://raw.githubusercontent.com/danielvarga/deepdream-aws/master/setup.sh
# Also, in your fork, change the git SSH URL in setup.sh to point to your fork.

ssh -i $pem ubuntu@$dns bash setup.sh
# ...wait some, and then:
scp -i $pem ubuntu@$dns:./deepdream-aws/daniel.conv2-3x3_reduce.jpg .
# ...wait a lot, and then:
mkdir daniel
scp -i $pem ubuntu@$dns:./deepdream-aws/daniel.*.jpg daniel/

#####################

# dream.py supports masking: if you run it on a file f.jpg, and the
# program finds a mask file mask_f.jpg in its directory, then it won't change the
# pixels that are white on the mask. The mask must be of the same size, and
# must not be greyscale.
