mkdir ../infrastructure/build

# build fetch function
cd fetch_jobs_lambda
zip -r ../../infrastructure/build/fetch_jobs_lambda.zip .
cd .. 

# build request layer
cd requests_layer
pip install -r requirements.txt -t python/lib/python3.9/site-packages
zip -r ../../infrastructure/build/requests_layer.zip .
cd ..