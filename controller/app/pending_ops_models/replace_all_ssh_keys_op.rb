class ReplaceAllSshKeysOp < PendingAppOp

  field :keys_attrs, type: Array, default: []
  field :gear_id, type: String

  def is_parallel_executable
    return true
  end

  def add_parallel_execute_job(handle)
    gear = get_gear()
    unless gear.removed
      job = gear.get_fix_authorized_ssh_keys_job(keys_attrs)
      tag = { "op_id" => self._id.to_s }
      RemoteJob.add_parallel_job(handle, tag, gear, job)
    end
  end

end
