defmodule MyAppWeb.PostJSON do
  alias MyApp.Schemas.{Comment.Comment, Post.Post}
  def render("show.json", %{post: post_resp})do
    {:ok, post} = post_resp
    %{data: show_data(post)}
  end
  def render("index.json", %{posts: posts_resp}) do
    %{posts: for(post <- posts_resp, do: index_data(post))}
  end

  defp show_data(%Post{} = post) do
    %{
      user_id: post.user_id,
      title: post.title,
      content: post.content
    }
  end

  defp index_data(%Post{} = post) do
    %{
      post: %{
      post_id: post.id,
      user_id: post.user_id,
      content: post.content,
      comments: for(comment <- post.comments, do: data_comment(comment))
    }
    }
  end

  defp data_comment(%Comment{} = comment) do
    comment.replies|>IO.inspect()
    %{
      comment: %{
      post_id: comment.post_id,
      user_id: comment.user_id,
      content: comment.content,
      replies: for(reply <- comment.replies, do: data_reply(reply))
    }

    }
  end

  defp data_reply(%Comment{} = reply) do
    %{
      reply_id: reply.id,
      comment_id: reply.parent_id,
      user_id: reply.user_id,
      content: reply.content
    }
  end
end
