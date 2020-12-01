defmodule Investir.NewsTest do
  use Investir.DataCase

  alias Investir.News

  describe "stories" do
    alias Investir.News.Story

    @valid_attrs %{
      author: "some author",
      body: "some body",
      headline: "some headline",
      teaser: "some teaser"
    }
    @update_attrs %{
      author: "some updated author",
      body: "some updated body",
      headline: "some updated headline",
      teaser: "some updated teaser"
    }
    @invalid_attrs %{author: nil, body: nil, headline: nil, teaser: nil}

    def story_fixture(attrs \\ %{}) do
      {:ok, story} =
        attrs
        |> Enum.into(@valid_attrs)
        |> News.create_story()

      story
    end

    test "list_stories/0 returns all stories" do
      story = story_fixture()
      assert News.list_stories() == [story]
    end

    test "get_story!/1 returns the story with given id" do
      story = story_fixture()
      assert News.get_story!(story.id) == story
    end

    test "create_story/1 with valid data creates a story" do
      assert {:ok, %Story{} = story} = News.create_story(@valid_attrs)
      assert story.author == "some author"
      assert story.body == "some body"
      assert story.headline == "some headline"
      assert story.teaser == "some teaser"
    end

    test "create_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = News.create_story(@invalid_attrs)
    end

    test "update_story/2 with valid data updates the story" do
      story = story_fixture()
      assert {:ok, %Story{} = story} = News.update_story(story, @update_attrs)
      assert story.author == "some updated author"
      assert story.body == "some updated body"
      assert story.headline == "some updated headline"
      assert story.teaser == "some updated teaser"
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = story_fixture()
      assert {:error, %Ecto.Changeset{}} = News.update_story(story, @invalid_attrs)
      assert story == News.get_story!(story.id)
    end

    test "delete_story/1 deletes the story" do
      story = story_fixture()
      assert {:ok, %Story{}} = News.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> News.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = story_fixture()
      assert %Ecto.Changeset{} = News.change_story(story)
    end
  end
end
