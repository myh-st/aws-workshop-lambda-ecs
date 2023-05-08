## Package libraries with Lambda Layers and use them in a Python-based AWS Lambda function:

## Before starting this workshop
Prerequisites:

    AWS Account
    Cloud 9
        - Docker Installed
        - AWS CLI Installed

## Login to AWS console

<img width="1117" alt="image" src="https://user-images.githubusercontent.com/37788058/235129149-d5fdbaa1-4f3a-48df-9098-604c35fe38bf.png">

- Search : cloud9

<img width="900" alt="image" src="https://user-images.githubusercontent.com/37788058/235129306-a124cfa2-b0b0-4a88-a1e0-4c1b12ab6fd1.png">

- Click on Open to open Cloud9 IDE ( Please choose the right Owner ARN to your AWS Accout username )

![image](https://user-images.githubusercontent.com/37788058/235130532-8a9a04ed-429d-4e31-b812-33d4597e3a15.png)

![image](https://user-images.githubusercontent.com/37788058/235131081-790f8645-668e-4bf0-8d55-2e0e0676dac8.png)

## Let’s Get Started

![image](https://user-images.githubusercontent.com/37788058/236745238-a1fa1d25-85f3-4197-b1a2-d589f3719b9c.png)

## 1\. Create a virtual environment for your project

Create a new folder on your computer and navigate into it using the command line interface. Then, create a new virtual environment by running the following command:

```
python -m venv myenv
```

Activate this environment by running:

```
source myenv/bin/activate
```

This will ensure that any packages you install from now on will be isolated to this specific project.

## 2\. Install pandas library

Install any necessary libraries or packages you want to include in your Lambda layer. For example, let's install the popular `pandas` library by running:

```
pip install pandas
```

You may add additional packages if needed.

## 3\. Create a folder for your Lambda layer

Create a new folder called "python" within your project directory. This folder should contain a subfolder called "lib", which is where our installed libraries will be placed.

```
mkdir -p python/lib/python3.7/site-packages/
```

## 4\. Copy installed packages into the folder

Copy all the installed packages from your virtual environment to the newly created folder for the Lambda Layer by running the below shell command

```
cp -r ./myenv/lib/python3.7/site-packages/* ./python/lib/python3.7/site-packages/
sudo chown -R $USER:$USER .
```

## 5\. Package the folder into a ZIP file

Go ahead and zip up the folder like so:

```
zip -r pandas_layer.zip python
```

This command will create a compressed archive called `pandas_layer.zip`.

Right click to Download 'pandas_later.zip' file

<img width="300" alt="image" src="https://user-images.githubusercontent.com/37788058/235095891-7dec51f6-27f9-4a56-8c3f-78051d868939.png">

## 6\. Create a layer in AWS Lambda

Now go to your AWS console and create a new layer from this .zip archive.

- Go to the [AWS Lambda Console](https://console.aws.amazon.com/lambda/home?region=ap-southeast-1#/functions)
  <img width="1170" alt="image" src="https://user-images.githubusercontent.com/37788058/232672613-f32127d2-cee3-4079-8075-7f9e9ef49507.png">

- Click on **Layers**
- Click on **Create Layer**

![image](https://user-images.githubusercontent.com/37788058/232672718-e31aabe0-4720-4eb9-ad60-307b4ab2ac6e.png)

- Enter a name (e.g., PandasLayer) and an optional description.
- Upload the zip file you created earlier
- Specify a compatible runtime (e.g., Python 3.7)
- Click on **Create**

## 7\. Attach the layer to your Lambda function

Now that your new Lambda layer is ready, you need to attach it to a Lambda function. Here's how to do it:

<img width="1124" alt="image" src="https://user-images.githubusercontent.com/37788058/232672985-e74ff662-9350-4536-ab3e-4b563ee848ab.png">

![image](https://user-images.githubusercontent.com/37788058/232673160-d8a11f13-9793-432b-aa28-c95a790d7cee.png)

- Go to the [AWS Lambda Console](https://console.aws.amazon.com/lambda/home?region=ap-southeast-1#/functions)
- Select the function you want to add the layer to, or create a new one.
- Scroll down to the **Lambda layers** section, then click on **Add a layer**

<img width="1117" alt="image" src="https://user-images.githubusercontent.com/37788058/232673187-d31f0af9-5319-4502-9e7e-8063d882ced3.png">

- Choose **Custom layers**, then select the layer you just created from the list.

![image](https://user-images.githubusercontent.com/37788058/232673288-00c51df8-605b-409f-a268-e16fdb481b74.png)

- Save your changes.

From now on, your Lambda function has access to whichever packages your layer contains.

Sample code to use the pandas_layer.zip with a Lambda function:

- Copy code below and paste it to lambda_function box

```python
import json
import pandas as pd

def lambda_handler(event, context):
    # Load data into a Pandas DataFrame
    data = [
        {"Name": "John", "Age": 28},
        {"Name": "Jane", "Age": 32},
        {"Name": "Bob", "Age": 45}
    ]
    df = pd.DataFrame(data)

    # Perform some analysis on the data
    avg_age = df["Age"].mean()

    # Return the results as JSON
    return {
        'statusCode': 200,
        'body': json.dumps({
            'average_age': avg_age
        })
    }
```

![image](https://user-images.githubusercontent.com/37788058/232673782-77d606a8-3fad-4d12-b863-6b18ffa337c7.png)

- Click on Test
- Enter a Event name
- Click on Save
  <img width="760" alt="image" src="https://user-images.githubusercontent.com/37788058/232674045-463d8fa4-5fab-484f-ac32-0f46cc4905dc.png">

- Click on Test

<img width="878" alt="image" src="https://user-images.githubusercontent.com/37788058/235098211-e917a922-3baf-4fae-b1ea-9aed9033ab6e.png">


## (Optional) Add a Lambda Layer from an S3 bucket

You can add a Lambda Layer from an S3 bucket by following the below steps:

1.  Create an S3 bucket if you don't have one already and upload the layer zip file to that bucket.
2.  Copy the S3 object URL of the layer zip file. (This can be found in the "Properties" tab of your uploaded layer zip file.)
3.  Open the AWS Console and navigate to your Lambda function.
4.  Scroll down to the "Layers" section and click on "Add a layer".
5.  Choose "Provide a layer version ARN", input a name for the layer, paste the S3 object URL into the "S3 link URL" field, and choose a compatible runtime (e.g. Python 3.7).
6.  Click "Create".
7.  Once the layer has been created, it will show up under "Layers" in your Lambda function console.

Noted : ควรใช้วิธี python venv ให้ runtime version ตรงกันกับที่ใช้บน Lambda Function เพื่อความ compatible
