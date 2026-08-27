// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorJohnnySonic
import Testing

struct DKMHaasTests {
}

// MARK: -

extension DKMHaasTests {
    @Test
    func equality() {
        let lhs = DKMHaas(enabled: true, minDelay: 10.0, maxDelay: 40.0, reverbSend: false)
        let rhs = DKMHaas(enabled: true, minDelay: 10.0, maxDelay: 40.0, reverbSend: false)

        #expect(lhs == rhs)
    }

    @Test
    func hashable() {
        let set: Set<DKMHaas> = [DKMHaas(enabled: true, minDelay: 10.0, maxDelay: 40.0, reverbSend: false),
                                 DKMHaas(enabled: true, minDelay: 10.0, maxDelay: 40.0, reverbSend: false),
                                 DKMHaas(enabled: false, minDelay: 10.0, maxDelay: 40.0, reverbSend: false)]

        #expect(set.count == 2)
    }

    @Test
    func inequality() {
        let base = DKMHaas(enabled: true, minDelay: 10.0, maxDelay: 40.0, reverbSend: false)

        #expect(base != DKMHaas(enabled: false, minDelay: 10.0, maxDelay: 40.0, reverbSend: false))
        #expect(base != DKMHaas(enabled: true, minDelay: 10.0, maxDelay: 40.0, reverbSend: true))
    }

    @Test
    func init_setsProperties() {
        let haas = DKMHaas(enabled: true, minDelay: 5.0, maxDelay: 90.0, reverbSend: true)

        #expect(haas.enabled)
        #expect(haas.minDelay == 5.0)
        #expect(haas.maxDelay == 90.0)
        #expect(haas.reverbSend)
    }
}
