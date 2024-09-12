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

  def collaborator?(repository:, username:)
    get "/repos/#{repository}/collaborators/#{username}"
    true
  rescue GithubClient::NotFound
    false
  end

  def add_collaborator(repository:, username:)
    # Permissions are only allowed on Organization repositories
    if user(repository.split("/").first).type == "Organization"
      put "/repos/#{repository}/collaborators/#{username}", body: { permission: :triage }
    else
      put "/repos/#{repository}/collaborators/#{username}"
    end
  end

  def remove_collaborator(repository:, username:)
    if collaborator?(repository: repository, username: username)
      delete "/repos/#{repository}/collaborators/#{username}"
    elsif (invitation = invitations(repository: repository).find{ _1.invitee.login == username })
      delete_invitation(repository: repository, id: invitation.id)
    end
  end

  def invitations(repository:)
    get "/repos/#{repository}/invitations", query: {per_page: 100}
  end

  def delete_invitation(repository:, id:)
    delete "/repos/#{repository}/invitations/#{id}"
  end

  def default_headers
    super.merge(
      "Accept" => "application/vnd.github+json",
      "X-GitHub-Api-Version" => "2022-11-28"
    )
  end
end
