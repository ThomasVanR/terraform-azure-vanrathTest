variable "prefix" {
  description = "Optionally change the resource name prefix [default = rg]"
  type        = string
  default     = "rsg"
}

variable "suffix" {
  description = "Resource name suffix: max 86 characters"
  type        = string

  validation {
    condition     = length(regexall("^[a-zA-Z0-9-._\\(\\)]+[a-zA-Z0-9-_\\(\\)]$", var.suffix)) > 0 && length(var.suffix) <= 86
    error_message = "The given name is not valid for Resource Group."
  }
}

variable "location" {
  description = "The location where this should resource be deployed"
  type        = string
}

variable "tags" {
  description = "Map of tags"
  type        = map(string)
  default     = {}
}

variable "lock_levels" {
  description = "Specifies the Level to be used for one or more RG locks. Possible values are Empty (no lock), CanNotDelete and ReadOnly."
  type        = list(string)
  default     = []
}