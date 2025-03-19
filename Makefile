# Target to add (stage) changes, commit them to the local repository and push them to the Github remote repository.
add_commit_and_push:
	@read -p "Enter commit message: " message; \
	echo "Adding changes..."; \
	git add .; \
	echo "Committing changes..."; \
	git commit -m "$$message"; \
	echo "Pushing to remote repository..."; \
	git push; \
	echo "Done"

commit:
	@read -p "Enter commit message: " message; \
	echo "Adding changes..."; \
	git add .; \
	echo "Committing changes..."; \
	git commit -m "$$message"; \
	echo "Done"

push:
	@echo "Pushing to remote repository..."; \
	git push; \
	echo "Done"

tag:
	@read -p "Enter tag to reassign: " tagname; \
	if git rev-parse "$$tagname" >/dev/null 2>&1; then \
		git tag -d "$$tagname"; \
		git push origin :refs/tags/$$tagname; \
	fi; \
	git tag "$$tagname"; \
	git push origin "$$tagname"; \
	echo "The $$tagname tag has been reassigned."

tags:
	@echo "The tags in this repository are ..."; \
	git tag

update:
	@echo "Fetching all branches from remote..."
	@git fetch --all > /dev/null
	
	@echo "Creating local tracking branches..."
	@for branch in $$(git branch -r | grep -v '\->'); do \
		git branch --track $${branch#origin/} $$branch > /dev/null 2>&1 || true; \
	done
	
	@echo "Pulling latest changes for all branches..."
	@for branch in $$(git branch | sed 's/*//'); do \
		git checkout $$branch > /dev/null 2>&1; \
		git pull -q; \
	done
	git checkout main

.PHONY: add_commit_and_push,commit,push,tag,tags,update,merge
