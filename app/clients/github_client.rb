class GithubClient < ApplicationClient
  BASE_URI = "https://api.github.com"

  def initialize
    super token: SellRepo.github_token
  end

  def user(username)
    get "/users/#{username}"
  end

  def repository(repository)
    get "/repos/#{repository}"
  end

  def add_collaborator(repository:, username:)
    # Permissions are only allowed on Organization repositories
    user = repository.split("/").first
    if user.type == "Organization"
      put "/repos/#{repository}/collaborators/#{username}", body: {permission: :triage}
    else
      put "/repos/#{repository}/collaborators/#{username}"
    end
  end

  def remove_collaborator(repository:, username:)
    delete "/repos/#{repository}/collaborators/#{username}"
  end

  def default_headers
    super.merge(
      "Accept" => "application/vnd.github+json",
      "X-GitHub-Api-Version" => "2022-11-28"
    )
  end
end
