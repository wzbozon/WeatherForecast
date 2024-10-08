import logging
from openai import OpenAI
import os
import requests

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# GitHub environment variables
repo_owner = os.getenv("GITHUB_REPOSITORY_OWNER")
repo_name = os.getenv("GITHUB_REPOSITORY").split("/")[1]
pr_number = os.getenv("GITHUB_REF").split("/")[2]
token = os.getenv("GITHUB_TOKEN")

if not token:
    raise ValueError("GITHUB_TOKEN environment variable is not set")

logging.info(f"Repository Owner: {repo_owner}")
logging.info(f"Repository Name: {repo_name}")
logging.info(f"Pull Request Number: {pr_number}")

# Fetch PR diff
headers = {"Authorization": f"token {token}", "Accept": "application/vnd.github.v3.diff"}
diff_url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/pulls/{pr_number}"
logging.info(f"Fetching PR diff from URL: {diff_url}")
diff_response = requests.get(diff_url, headers=headers)

if diff_response.status_code != 200:
    logging.error(f"Failed to fetch PR diff: {diff_response.status_code} - {diff_response.text}")
    raise SystemExit(f"Failed to fetch PR diff: {diff_response.status_code} - {diff_response.text}")

diff = diff_response.text
logging.info("Fetched PR diff")
logging.info(f"PR Diff: {diff}")

# Call Codex API to review the code
client = OpenAI(
    api_key=os.environ.get("OPENAI_API_KEY"),
)
logging.info("Calling Codex API for code review")

prompt = f"Provide a Code Review focusing on potential crashes and code clarity for the following diff:\n\n{diff}"

response = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": prompt,
        }
    ],
    model="gpt-3.5-turbo",
)
logging.info("Received response from Codex API")
logging.info(f"Response: {response.choices[0].message.content.strip()}")

# Post Codex feedback to the PR as a comment
comment_url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/issues/{pr_number}/comments"
comment = {
    "body": f"{response.choices[0].message.content.strip()}"
}
logging.info(f"Posting comment to URL: {comment_url}")
try:
    response = requests.post(comment_url, json=comment, headers=headers)
    response.raise_for_status()
    logging.info("Posted comment to PR")
except requests.exceptions.RequestException as e:
    logging.error(f"Failed to post comment: {e}")
    logging.error(f"Response status code: {response.status_code}")
    logging.error(f"Response text: {response.text}")
