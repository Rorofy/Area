const axios = require("axios")

async function getGithubPush(repository, token) {
  const URL = `https://api.github.com/repos/${repository}`;
  const after = Date.now()
  try {
    const repo = await axios.get(URL, {
      headers: {
        Authorization: "token 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",
      },
    })
    const res = []
    if (after - Date.parse(repo.data.pushed_at) > 60000) {
      return {
        message: "",
        data: []
      }
    } else {
      return {
        message: "Un push a été fait sur le repo " + repository,
        data: [true]
      }
    }
  } catch (e) {
    //console.error(e)
  }
}

module.exports.getGithubPush = getGithubPush;