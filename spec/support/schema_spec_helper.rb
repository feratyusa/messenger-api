require "json-schema"

def empty_schema
  {}
end

def conversations_list_schema
  {
    "type" => "object",
    "required" => ["id", "with_user", "last_message", "unread_count"],
    "properties" => {
      "id" => {
        "type" => "integer",
      },
      "with_user" => {
        "type" => "object",
        "required" => ["id", "name", "photo_url"],
        "properties" => {
          "id" => {
            "type" => "integer",
          },
          "name" => {
            "type" => "string",
          },
          "photo_url" => {
            "type" => "string",
          },
        }
      },
      "last_message" => {
        "type" => "object",
        "required" => ["id", "sender", "sent_at"],
        "properties" => {
          "id" => {
            "type" => "integer",
          },
          "sender" => {
            "type" => "object",
            "required" => ["id", "name"],
            "properties" => {
              "id" => {
                "type" => "integer",
              },
              "name" => {
                "type" => "string",
              },
            }
          },
          "sent_at" => {
            "type" => "string",
          },
        }
      },
      "unread_count" => {
        "type" => "integer"
      }
    }
  }
end

def conversation_index_schema
  {
    "type" => "object",
    "required" => ["id", "with_user"],
    "properties" => {
      "id" => {
        "type" => "integer",
      },
      "with_user" => {
        "type" => "object",
        "required" => ["id", "name", "photo_url"],
        "properties" => {
          "id" => {
            "type" => "integer",
          },
          "name" => {
            "type" => "string",
          },
          "photo_url" => {
            "type" => "string",
          },
        }
      }
    }
  }
end

def texts_list_schema
  {
    "type" => "object",
    "required" => ["id", "message", "sender", "sent_at"],
    "properties" => {
      "id" => {
        "type" => "integer",
      },
      "message" => {
        "type" => "string",
      },
      "sent_at" => {
        "type" => "string",
      },
      "sender" => {
        "type" => "object",
        "required" => ["id", "name", "photo_url"],
        "properties" => {
          "id" => {
            "type" => "integer",
          },
          "name" => {
            "type" => "string",
          },
          "photo_url" => {
            "type" => "string",
          },
        }
      }
    }
  }
end

def text_created_schema
  {
    "type" => "object",
    "required" => ["id", "message", "sender", "sent_at", "conversation"],
    "properties" => {
      "id" => {
        "type" => "integer",
      },
      "message" => {
        "type" => "string",
      },
      "sent_at" => {
        "type" => "string",
      },
      "sender" => {
        "type" => "object",
        "required" => ["id", "name", "photo_url"],
        "properties" => {
          "id" => {
            "type" => "integer",
          },
          "name" => {
            "type" => "string",
          },
          "photo_url" => {
            "type" => "string",
          },
        }
      },
      "conversation" => {
        "type" => "object",
        "required" => ["id", "with_user"],
        "properties" => {
          "id" => {
            "type" => "integer",
          },
          "with_user" => {
            "type" => "object",
            "required" => ["id", "name", "photo_url"],
            "properties" => {
              "id" => {
                "type" => "integer",
              },
              "name" => {
                "type" => "string",
              },
              "photo_url" => {
                "type" => "string",
              }
            }
          }
        }
      }
    }
  }
end
