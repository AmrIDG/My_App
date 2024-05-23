defmodule MyAppWeb.CommentJSON do
  alias MyApp.Schemas.Comment.Comment
  def render("show.json", %{comment: comment_resp}) do
    {:ok, comment} = comment_resp
    %{data: show_comment(comment)}
  end

  def render("index.json", %{comments: comments_resp}) do
    %{comments: for(comment <- comments_resp, do: index_comment(comment))}
  end

  defp show_comment(%Comment{} = comment) do
    comment.replies |> IO.inspect()

    %{
      comment: %{
        post_id: comment.post_id,
        user_id: comment.user_id,
        content: comment.content
      }
    }
  end

  defp index_comment(%Comment{} = comment) do
    comment.replies |> IO.inspect()

    %{
      comment: %{
        post_id: comment.post_id,
        user_id: comment.user_id,
        content: comment.content,
        replies: for(reply <- comment.replies, do: index_replies(reply))
      }
    }
  end

  defp index_replies(%Comment{} = reply) do
    %{
      reply_id: reply.id,
      comment_id: reply.parent_id,
      user_id: reply.user_id,
      content: reply.content
    }
  end
end
