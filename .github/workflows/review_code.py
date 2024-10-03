import openai
import os
import requests

# GitHub environment variables
repo_owner = os.getenv("GITHUB_REPOSITORY_OWNER")
repo_name = os.getenv("GITHUB_REPOSITORY").split("/")[1]
pr_number = os.getenv("GITHUB_REF").split("/")[2]
token = os.getenv("GITHUB_TOKEN")

# Fetch PR diff
headers = {"Authorization": f"token {token}"}
diff_url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/pulls/{pr_number}"
diff_response = requests.get(diff_url, headers=headers)
diff = diff_response.text

# Call Codex API to review the code
openai.api_key = os.getenv("OPENAI_API_KEY")
response = openai.Completion.create(
    engine="code-davinci-002",
    prompt=f"Review the following code for issues:\n{diff}",
    max_tokens=500
)

# Post Codex feedback to the PR as a comment
comment_url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/issues/{pr_number}/comments"
comment = {
    "body": f"AI Code Review:\n{response.choices[0].text.strip()}"
}
requests.post(comment_url, json=comment, headers=headers)

